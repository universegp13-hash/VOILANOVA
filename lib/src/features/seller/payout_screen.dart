import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/seller_provider.dart';
import '../../models/payout_request.dart';
import '../../core/formatters.dart';

class PayoutScreen extends ConsumerStatefulWidget {
  const PayoutScreen({super.key});

  @override
  ConsumerState<PayoutScreen> createState() => _PayoutScreenState();
}

class _PayoutScreenState extends ConsumerState<PayoutScreen> {
  final amountController = TextEditingController();
  final accountController = TextEditingController();
  String selectedMethod = 'M-Pesa';

  @override
  Widget build(BuildContext context) {
    final payouts = ref.watch(sellerPayoutsProvider);
    const availableBalance = 38700.0;

    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Payout Settlements',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Available Funds',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  Text(Formatters.price(availableBalance),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 18)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          buildInput('Withdrawal Amount', amountController,
              keyboardType: TextInputType.number),
          buildInput('M-Pesa Number or PayPal Email', accountController),
          DropdownButtonFormField<String>(
            initialValue: selectedMethod,
            items: ['M-Pesa', 'PayPal', 'PesaLink', 'Airtel Money']
                .map((method) =>
                    DropdownMenuItem(value: method, child: Text(method)))
                .toList(),
            onChanged: (value) =>
                setState(() => selectedMethod = value ?? 'M-Pesa'),
            decoration: InputDecoration(
              labelText: 'Payout Method',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton(
              onPressed: createPayoutRequest,
              child: const Text('Request Withdrawal')),
          const SizedBox(height: 20),
          const Text('Recent Payouts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 14),
          Expanded(
            child: ListView.builder(
              itemCount: payouts.length,
              itemBuilder: (context, index) {
                final payout = payouts[index];
                return buildPayoutTile(payout);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInput(String label, TextEditingController controller,
      {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
    );
  }

  Widget buildPayoutTile(PayoutRequest payout) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(Formatters.price(payout.amount)),
        subtitle: Text('${payout.method} • ${payout.status}'),
        trailing: Text(payout.transactionCode),
      ),
    );
  }

  void createPayoutRequest() {
    final amount = double.tryParse(amountController.text.trim()) ?? 0;
    if (amount <= 0) return;
    final request = PayoutRequest(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sellerId: 'seller-uuid-001',
      amount: amount,
      method: selectedMethod,
      status: 'pending',
      transactionCode: 'REQ-${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
    );
    ref
        .read(sellerPayoutsProvider.notifier)
        .update((state) => [request, ...state]);
    amountController.clear();
    accountController.clear();
  }
}
