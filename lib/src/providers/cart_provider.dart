import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../core/constants.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void add(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index)
            CartItem(product: state[i].product, quantity: state[i].quantity + 1)
          else
            state[i]
      ];
    } else {
      state = [...state, CartItem(product: product, quantity: 1)];
    }
  }

  void remove(Product product) {
    state = state.where((item) => item.product.id != product.id).toList();
  }

  void updateQuantity(Product product, int quantity) {
    state = state
        .map((item) => item.product.id == product.id
            ? CartItem(product: item.product, quantity: quantity)
            : item)
        .where((item) => item.quantity > 0)
        .toList();
  }

  double get subtotal => state.fold(0, (sum, item) => sum + item.subtotal);
  double get vat => subtotal * kVatInclusive;
  double get total => subtotal + vat;
}
