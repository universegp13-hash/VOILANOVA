import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/formatters.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/checkout_sheet.dart';
import '../../widgets/receipt_modal.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final cartState = ref.watch(cartProvider.notifier);
    final subtotal = cartState.subtotal;
    final vat = cartState.vat;
    final total = cartState.total;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Cart',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            Expanded(
              child: cart.isEmpty
                  ? const Center(
                      child: Text(
                          'Your cart is empty. Add premium items from the home feed.'))
                  : ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final item = cart[index];
                        final lineTotal = item.product.price * item.quantity;
                        return Card(
                          margin: const EdgeInsets.only(bottom: 14),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: item.product.primaryImageUrl,
                                    width: 72,
                                    height: 72,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                        color: Colors.grey.shade200,
                                        width: 72,
                                        height: 72),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                            color: Colors.grey.shade200,
                                            width: 72,
                                            height: 72,
                                            child: const Icon(
                                                Icons.image_not_supported)),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(item.product.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                      const SizedBox(height: 6),
                                      Text(Formatters.price(item.product.price),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      const SizedBox(height: 6),
                                      Text(
                                          'Line: ${Formatters.price(lineTotal)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                              Icons.remove_circle_outline),
                                          onPressed: () {
                                            final newQty = (item.quantity - 1)
                                                .clamp(0, 999);
                                            if (newQty == 0) {
                                              cartState.remove(item.product);
                                              return;
                                            }
                                            cartState.updateQuantity(
                                                item.product, newQty);
                                          },
                                        ),
                                        Text('${item.quantity}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                        IconButton(
                                          icon: const Icon(
                                              Icons.add_circle_outline),
                                          onPressed: () =>
                                              cartState.updateQuantity(
                                                  item.product,
                                                  item.quantity + 1),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline,
                                          color: Colors.redAccent),
                                      onPressed: () =>
                                          cartState.remove(item.product),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    rowTile('Subtotal', Formatters.price(subtotal)),
                    const SizedBox(height: 8),
                    rowTile('VAT (16%)', Formatters.price(vat)),
                    const Divider(height: 26),
                    rowTile('Total', Formatters.price(total), emphasize: true),
                    const SizedBox(height: 18),
                    ElevatedButton(
                      onPressed: cart.isEmpty
                          ? null
                          : () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: CheckoutSheet(
                                    items: cart,
                                    total: total,
                                    onComplete: () {
                                      Navigator.of(context).pop();
                                      showDialog(
                                        context: context,
                                        builder: (_) => ReceiptModal(
                                            total: total, items: cart),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                      child: const Text('Proceed to Checkout'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowTile(String label, String value, {bool emphasize = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontWeight: emphasize ? FontWeight.w700 : FontWeight.w500)),
        Text(value,
            style: TextStyle(
                fontWeight: emphasize ? FontWeight.w700 : FontWeight.w500)),
      ],
    );
  }
}
