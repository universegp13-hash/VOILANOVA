import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/bottom_nav.dart';
import '../home/home_screen.dart';
import '../search/search_screen.dart';
import '../orders/orders_screen.dart';
import '../profile/profile_screen.dart';
import '../cart/cart_screen.dart';
import '../seller/seller_portal_screen.dart';
import '../admin/admin_panel_screen.dart';

class ShellScreen extends ConsumerStatefulWidget {
  final int initialIndex;
  const ShellScreen({super.key, this.initialIndex = 0});

  @override
  ConsumerState<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends ConsumerState<ShellScreen> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final role = ref.watch(authRoleProvider);
    final screens = <Widget>[
      const HomeScreen(),
      const SearchScreen(),
      const CartScreen(),
      const OrdersScreen(),
      const ProfileScreen(),
      const SellerPortalScreen(),
      const AdminPanelScreen(),
    ];

    final availableTabs = <int>[0, 1, 2, 3, 4];
    if (role == 'seller') {
      availableTabs.add(5);
    }
    if (role == 'admin') {
      availableTabs.add(6);
    }

    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNav(
        selectedIndex: selectedIndex,
        onTap: (value) {
          if (availableTabs.contains(value)) {
            setState(() => selectedIndex = value);
          }
        },
        role: role,
      ),
    );
  }
}
