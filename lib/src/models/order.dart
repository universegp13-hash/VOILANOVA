class Order {
  final String id;
  final String customerId;
  final List<Map<String, dynamic>> itemsJson;
  final double totalPrice;
  final double netEarnings;
  final double platformFee;
  final String paymentMethod;
  final String status;
  final Map<String, dynamic> shippingAddressJson;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.customerId,
    required this.itemsJson,
    required this.totalPrice,
    required this.netEarnings,
    required this.platformFee,
    required this.paymentMethod,
    required this.status,
    required this.shippingAddressJson,
    required this.createdAt,
  });
}
