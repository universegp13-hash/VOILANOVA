import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/seller_provider.dart';
import '../../widgets/analytics_card.dart';
import '../../widgets/chart_section.dart';
import 'inventory_screen.dart';
import 'payout_screen.dart';

class SellerPortalScreen extends ConsumerStatefulWidget {
  const SellerPortalScreen({super.key});

  @override
  ConsumerState<SellerPortalScreen> createState() => _SellerPortalScreenState();
}

class _SellerPortalScreenState extends ConsumerState<SellerPortalScreen> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final revenueData = ref.watch(sellerSalesProvider);
    final topProducts = ref.watch(sellerTopProductsProvider);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              children: [
                const Expanded(
                    child: Text('Seller Dashboard',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w700))),
                ElevatedButton(
                    onPressed: () => setState(() => tabIndex = 1),
                    child: const Text('Inventory')),
                const SizedBox(width: 12),
                ElevatedButton(
                    onPressed: () => setState(() => tabIndex = 2),
                    child: const Text('Payouts')),
              ],
            ),
          ),
          if (tabIndex == 0)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Expanded(
                            child: AnalyticsCard(
                                title: 'Total Balance',
                                value: 'KSh 38,700',
                                subtitle: 'Available to withdraw',
                                accentColor: Color(0xFF342EEC))),
                        SizedBox(width: 12),
                        Expanded(
                            child: AnalyticsCard(
                                title: 'Units Sold',
                                value: '152',
                                subtitle: 'Last 7 days',
                                accentColor: Color(0xFF6D4CFF))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const AnalyticsCard(
                        title: 'Average Order Value',
                        value: 'KSh 6,720',
                        subtitle: 'Customer basket size',
                        accentColor: Color(0xFF2EA6FF)),
                    const SizedBox(height: 16),
                    RevenueChart(data: revenueData),
                    const SizedBox(height: 14),
                    BarPerformanceChart(data: topProducts),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
          if (tabIndex == 1) const Expanded(child: InventoryScreen()),
          if (tabIndex == 2) const Expanded(child: PayoutScreen()),
        ],
      ),
    );
  }
}
