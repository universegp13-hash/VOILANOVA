import 'package:flutter/material.dart';
import '../core/formatters.dart';
import '../models/cart_item.dart';

class CheckoutSheet extends StatefulWidget {
  final List<CartItem> items;
  final double total;
  final VoidCallback onComplete;

  const CheckoutSheet(
      {super.key,
      required this.items,
      required this.total,
      required this.onComplete});

  @override
  State<CheckoutSheet> createState() => _CheckoutSheetState();
}

class _CheckoutSheetState extends State<CheckoutSheet> {
  String paymentMethod = 'M-Pesa';
  final phoneController = TextEditingController();
  final cardNumberController = TextEditingController();
  final cardNameController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();
  final paypalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Container(
                height: 4,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(16))),
            const SizedBox(height: 16),
            const Text('Checkout',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Text('Total due ${Formatters.price(widget.total)}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 18),
            DropdownButtonFormField<String>(
              initialValue: paymentMethod,
              items: [
                'M-Pesa',
                'PayPal',
                'Airtel Money',
                'PesaLink',
                'Credit Card'
              ]
                  .map((method) =>
                      DropdownMenuItem(value: method, child: Text(method)))
                  .toList(),
              onChanged: (value) =>
                  setState(() => paymentMethod = value ?? 'M-Pesa'),
              decoration: InputDecoration(
                labelText: 'Payment channel',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
            ),
            const SizedBox(height: 16),
            if (paymentMethod == 'M-Pesa' || paymentMethod == 'Airtel Money')
              buildPhoneField('Mobile phone number', phoneController),
            if (paymentMethod == 'PayPal' || paymentMethod == 'PesaLink')
              buildTextField('Account or email', paypalController),
            if (paymentMethod == 'Credit Card') ...[
              buildTextField('Cardholder name', cardNameController),
              const SizedBox(height: 12),
              buildTextField('Card number', cardNumberController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(
                    child: buildTextField('Expiry MM/YY', expiryController,
                        keyboardType: TextInputType.number)),
                const SizedBox(width: 12),
                Expanded(
                    child: buildTextField('CVV', cvvController,
                        keyboardType: TextInputType.number)),
              ]),
            ],
            const SizedBox(height: 18),
            Text('Items', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            ...widget.items.map((item) => buildCartLine(item)).toList(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: widget.onComplete,
              child: Text('Pay with $paymentMethod'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }

  Widget buildPhoneField(String label, TextEditingController controller) {
    return buildTextField(label, controller, keyboardType: TextInputType.phone);
  }

  Widget buildCartLine(CartItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text('${item.quantity} x ${item.product.title}',
                  overflow: TextOverflow.ellipsis)),
          Text(Formatters.price(item.subtotal)),
        ],
      ),
    );
  }
}
