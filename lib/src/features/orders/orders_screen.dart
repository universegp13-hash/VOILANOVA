import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = <Map<String, Object>>[
      {
        'id': 'ORD-1512',
        'status': 'Processing',
        'items': 'Luna Luxe Handbag',
        'total': 'KSh 4,950',
        'date': '2 hours ago',
        'color': const Color(0xFFFFC107),
      },
      {
        'id': 'ORD-1511',
        'status': 'Delivered',
        'items': 'Aurora Performance Sneakers',
        'total': 'KSh 6,200',
        'date': 'Yesterday',
        'color': Colors.green,
      },
      {
        'id': 'ORD-1509',
        'status': 'Shipped',
        'items': 'Nairobi Coffee Table',
        'total': 'KSh 10,450',
        'date': '2 days ago',
        'color': const Color(0xFF2196F3),
      },
      {
        'id': 'ORD-1508',
        'status': 'Cancelled',
        'items': 'Sculptured Glass Vase',
        'total': 'KSh 2,750',
        'date': '5 days ago',
        'color': Colors.red,
      },
    ];

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                'My Orders',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            sliver: SliverList.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final statusColor = order['color'] as Color;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(order['id'] as String,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  const SizedBox(height: 4),
                                  Text(order['date'] as String,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: statusColor.withOpacity(0.3)),
                                ),
                                child: Text(order['status'] as String,
                                    style: TextStyle(
                                        color: statusColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(order['items'] as String,
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              Text(order['total'] as String,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
