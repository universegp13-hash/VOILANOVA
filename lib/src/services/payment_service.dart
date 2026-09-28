import '../core/constants.dart';

class PaymentService {
  static double calculatePlatformFee(double subtotal) =>
      subtotal * kPlatformFeePercentage;

  static Map<String, dynamic> buildCheckoutPayload({
    required String customerId,
    required List<Map<String, dynamic>> items,
    required double subtotal,
    required String paymentMethod,
    required Map<String, dynamic> shippingAddress,
  }) {
    final platformFee = calculatePlatformFee(subtotal);
    final grossAmount = subtotal + subtotal * kVatInclusive;
    return {
      'customer_id': customerId,
      'items_json': items,
      'total_price': grossAmount,
      'net_earnings': subtotal - platformFee,
      'platform_fee': platformFee,
      'payment_method': paymentMethod,
      'status': 'processing',
      'shipping_address_json': shippingAddress,
      'created_at': DateTime.now().toIso8601String(),
    };
  }
}
