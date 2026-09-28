import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../core/formatters.dart';

class ReceiptModal extends StatelessWidget {
  final double total;
  final List<CartItem> items;

  const ReceiptModal({super.key, required this.total, required this.items});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Receipt Preview'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('VOILANOVA Marketplace'),
            const SizedBox(height: 10),
            const Text(
                'Thank you for your purchase. Review your receipt below.'),
            const SizedBox(height: 16),
            ...items.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text('${item.quantity}x ${item.product.title}',
                            maxLines: 1, overflow: TextOverflow.ellipsis)),
                    Text(Formatters.price(item.subtotal)),
                  ],
                ),
              );
            }),
            const Divider(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                Text(Formatters.price(total),
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Payment method: Credit Card'),
            const SizedBox(height: 10),
            const Text(
                'Delivery: Standard shipping to your preferred address.'),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close')),
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Print')),
      ],
    );
  }
}
