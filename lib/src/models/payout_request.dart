class PayoutRequest {
  final String id;
  final String sellerId;
  final double amount;
  final String method;
  final String status;
  final String transactionCode;
  final DateTime createdAt;

  PayoutRequest({
    required this.id,
    required this.sellerId,
    required this.amount,
    required this.method,
    required this.status,
    required this.transactionCode,
    required this.createdAt,
  });
}
