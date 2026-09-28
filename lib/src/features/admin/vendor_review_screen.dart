import 'package:flutter/material.dart';
import '../../models/product.dart';

class VendorReviewScreen extends StatelessWidget {
  final List<Product> pendingProducts;
  final ValueChanged<List<Product>> onChange;

  const VendorReviewScreen(
      {super.key, required this.pendingProducts, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: ListView.builder(
        itemCount: pendingProducts.length,
        itemBuilder: (context, index) {
          final product = pendingProducts[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text(product.description,
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ActionChip(
                          label: const Text('Approve'),
                          onPressed: () => _updateStatus(index, 'approved')),
                      const SizedBox(width: 10),
                      ActionChip(
                          label: const Text('Reject'),
                          onPressed: () => _updateStatus(index, 'rejected')),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _updateStatus(int index, String status) {
    final updated = List<Product>.from(pendingProducts);
    final current = updated[index];
    updated[index] = Product(
      id: current.id,
      title: current.title,
      description: current.description,
      price: current.price,
      compareAtPrice: current.compareAtPrice,
      stock: current.stock,
      category: current.category,
      vendorId: current.vendorId,
      primaryImageUrl: current.primaryImageUrl,
      secondaryImagesUrls: current.secondaryImagesUrls,
      isFeatured: current.isFeatured,
      isDeal: current.isDeal,
      approvalStatus: status,
    );
    onChange(updated
        .where((product) => product.approvalStatus == 'pending')
        .toList());
  }
}
