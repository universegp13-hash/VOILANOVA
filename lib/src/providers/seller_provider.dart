import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../models/chart_data.dart';
import '../models/payout_request.dart';
import '../core/constants.dart';
import '../core/mock_data.dart';

final sellerSalesProvider = Provider<List<ChartData>>((ref) {
  return kSellerRevenueData;
});

final sellerTopProductsProvider = Provider<List<ChartData>>((ref) {
  return kSellerTopProducts;
});

final sellerInventoryProvider = StateProvider<List<Product>>((ref) {
  return kMockProducts
      .where((item) => item.vendorId == kDefaultSellerId)
      .toList();
});

final sellerPayoutsProvider = StateProvider<List<PayoutRequest>>((ref) {
  return kSellerPayoutRequests;
});
