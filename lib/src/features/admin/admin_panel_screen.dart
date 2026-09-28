import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/admin_provider.dart';
import '../../widgets/analytics_card.dart';
import '../admin/vendor_review_screen.dart';
import '../admin/audit_log_screen.dart';

class AdminPanelScreen extends ConsumerStatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  ConsumerState<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends ConsumerState<AdminPanelScreen> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pendingProducts = ref.watch(adminQueueProvider);
    final auditLogs = ref.watch(adminAuditProvider);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              children: [
                const Expanded(
                    child: Text('Admin Panel',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w700))),
                buildTabButton('Overview', 0),
                const SizedBox(width: 10),
                buildTabButton('Review', 1),
                const SizedBox(width: 10),
                buildTabButton('Audit', 2),
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
                                title: 'Gross Volume',
                                value: 'KSh 1.4M',
                                subtitle: 'Total revenue',
                                accentColor: Color(0xFF342EEC))),
                        SizedBox(width: 12),
                        Expanded(
                            child: AnalyticsCard(
                                title: 'Transactions',
                                value: '2,315',
                                subtitle: 'Completed orders',
                                accentColor: Color(0xFF6D4CFF))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const AnalyticsCard(
                        title: 'Registered Items',
                        value: '941',
                        subtitle: 'Active product listings',
                        accentColor: Color(0xFF2EA6FF)),
                    const SizedBox(height: 14),
                    const SizedBox(height: 8),
                    const Text('Engagement Matrix',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    const SizedBox(height: 200, child: Placeholder()),
                    const SizedBox(height: 18),
                    const Text('Broadcast Hub',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Send plain-text alert to social sales channels and vendor network.'),
                            SizedBox(height: 12),
                            TextField(
                              maxLines: 3,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Type broadcast message...'),
                            ),
                            SizedBox(height: 12),
                            Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                    onPressed: null, child: Text('Broadcast'))),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          if (tabIndex == 1)
            Expanded(
                child: VendorReviewScreen(
                    pendingProducts: pendingProducts,
                    onChange: (updated) =>
                        ref.read(adminQueueProvider.notifier).state = updated)),
          if (tabIndex == 2)
            Expanded(child: AuditLogScreen(auditLogs: auditLogs)),
        ],
      ),
    );
  }

  Widget buildTabButton(String label, int index) {
    final selected = tabIndex == index;
    return ElevatedButton(
      onPressed: () => setState(() => tabIndex = index),
      style: ElevatedButton.styleFrom(
          backgroundColor:
              selected ? const Color(0xFF342EEC) : Colors.grey.shade300),
      child: Text(label,
          style: TextStyle(color: selected ? Colors.white : Colors.black87)),
    );
  }
}
