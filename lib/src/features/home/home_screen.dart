import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/cart_provider.dart';
import '../../providers/countdown_provider.dart';
import '../../providers/product_provider.dart';
import '../../widgets/category_badge.dart';
import '../../widgets/countdown_card.dart';
import '../../widgets/product_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int selectedCategoryIndex = 0;
  final categories = ['All', 'Accessories', 'Home', 'Footwear', 'Furniture'];
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.88);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productListProvider);
    final countdown = ref.watch(dealCountdownProvider);
    final featured = ref.watch(featuredProductProvider).take(3).toList();
    final filteredProducts = selectedCategoryIndex == 0
        ? products
        : products
            .where((product) =>
                product.category == categories[selectedCategoryIndex])
            .toList();
    final cartItems = ref.watch(cartProvider);

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Shop the Extraordinary',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to cart
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 28,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          if (cartItems.isNotEmpty)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.error,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  cartItems.length.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Featured Products Carousel
          if (featured.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: SizedBox(
                  height: 240,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: featured.length,
                    itemBuilder: (context, index) {
                      final product = featured[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: CachedNetworkImage(
                                imageUrl: product.primaryImageUrl,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Container(color: Colors.grey.shade200),
                                errorWidget: (context, url, error) => Container(
                                  color: Colors.grey.shade200,
                                  child: const Icon(
                                      Icons.image_not_supported_outlined),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.6)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            Positioned(
                              left: 18,
                              bottom: 20,
                              right: 18,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'New Drop',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    product.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'From KSh ${product.price.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 13),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          // Deals Countdown
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child:
                  CountdownCard(title: 'Today\'s Deals', duration: countdown),
            ),
          ),
          // Categories
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return CategoryBadge(
                    label: categories[index],
                    active: selectedCategoryIndex == index,
                    onTap: () => setState(() => selectedCategoryIndex = index),
                  );
                },
              ),
            ),
          ),
          // Products List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            sliver: filteredProducts.isEmpty
                ? SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'No products available in this category',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  )
                : SliverList.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ProductCard(
                        product: product,
                        onAddToCart: () {
                          ref.read(cartProvider.notifier).add(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.title} added to cart'),
                              duration: const Duration(seconds: 2),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
