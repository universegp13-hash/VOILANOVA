class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final double compareAtPrice;
  final int stock;
  final String category;
  final String vendorId;
  final String primaryImageUrl;
  final List<String> secondaryImagesUrls;
  final bool isFeatured;
  final bool isDeal;
  final String approvalStatus;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.compareAtPrice,
    required this.stock,
    required this.category,
    required this.vendorId,
    required this.primaryImageUrl,
    required this.secondaryImagesUrls,
    required this.isFeatured,
    required this.isDeal,
    required this.approvalStatus,
  });
}
