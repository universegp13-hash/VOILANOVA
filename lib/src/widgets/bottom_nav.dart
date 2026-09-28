import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final String role;

  const BottomNav(
      {super.key,
      required this.selectedIndex,
      required this.onTap,
      required this.role});

  @override
  Widget build(BuildContext context) {
    final items = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
          icon: Icon(Icons.home_filled), label: 'Home'),
      const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart), label: 'Cart'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long), label: 'Orders'),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ];
    if (role == 'seller') {
      items.add(const BottomNavigationBarItem(
          icon: Icon(Icons.storefront), label: 'Seller'));
    }
    if (role == 'admin') {
      items.add(const BottomNavigationBarItem(
          icon: Icon(Icons.dashboard), label: 'Admin'));
    }

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.grey.shade600,
      items: items,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 12,
    );
  }
}
