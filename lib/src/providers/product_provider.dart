import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../core/mock_data.dart';

final productListProvider = Provider<List<Product>>((ref) {
  return kMockProducts;
});

final featuredProductProvider = Provider<List<Product>>((ref) {
  return ref
      .watch(productListProvider)
      .where((product) => product.isFeatured)
      .toList();
});

final dealProductProvider = Provider<List<Product>>((ref) {
  return ref
      .watch(productListProvider)
      .where((product) => product.isDeal)
      .toList();
});
