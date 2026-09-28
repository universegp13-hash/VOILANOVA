import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/product.dart';
import '../../providers/seller_provider.dart';

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});

  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  String selectedCategory = 'Accessories';
  bool isFeatured = false;
  bool isDeal = false;

  @override
  Widget build(BuildContext context) {
    final inventory = ref.watch(sellerInventoryProvider);
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const Text('Inventory Management',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                const SizedBox(height: 18),
                buildInput('Product Title', titleController),
                buildInput('Description', descriptionController, maxLines: 3),
                buildInput('Price', priceController,
                    keyboardType: TextInputType.number),
                buildInput('Stock', stockController,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 12),
                buildCategoryPicker(),
                const SizedBox(height: 12),
                Row(children: [
                  Checkbox(
                      value: isFeatured,
                      onChanged: (value) =>
                          setState(() => isFeatured = value ?? false)),
                  const Text('Featured'),
                  const SizedBox(width: 18),
                  Checkbox(
                      value: isDeal,
                      onChanged: (value) =>
                          setState(() => isDeal = value ?? false)),
                  const Text('Deal'),
                ]),
                ElevatedButton(
                    onPressed: createProduct, child: const Text('Add Product')),
                const SizedBox(height: 24),
                const Text('Your Active Inventory',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 14),
                ...inventory.map((product) => Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(product.title),
                        subtitle: Text(
                            '${product.category} • ${product.stock} in stock'),
                        trailing: Text(product.approvalStatus.toUpperCase(),
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInput(String label, TextEditingController controller,
      {int maxLines = 1, TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
    );
  }

  Widget buildCategoryPicker() {
    final categories = ['Accessories', 'Home', 'Footwear', 'Furniture'];
    return DropdownButtonFormField<String>(
      initialValue: selectedCategory,
      items: categories
          .map((category) =>
              DropdownMenuItem(value: category, child: Text(category)))
          .toList(),
      onChanged: (value) =>
          setState(() => selectedCategory = value ?? categories.first),
      decoration: InputDecoration(
        labelText: 'Category',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  void createProduct() {
    final newProduct = Product(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      price: double.tryParse(priceController.text.trim()) ?? 0,
      compareAtPrice: 0,
      stock: int.tryParse(stockController.text.trim()) ?? 0,
      category: selectedCategory,
      vendorId: 'seller-uuid-001',
      primaryImageUrl:
          'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=900&q=80',
      secondaryImagesUrls: [],
      isFeatured: isFeatured,
      isDeal: isDeal,
      approvalStatus: 'pending',
    );
    ref
        .read(sellerInventoryProvider.notifier)
        .update((state) => [...state, newProduct]);
    titleController.clear();
    descriptionController.clear();
    priceController.clear();
    stockController.clear();
    setState(() {
      isFeatured = false;
      isDeal = false;
    });
  }
}
