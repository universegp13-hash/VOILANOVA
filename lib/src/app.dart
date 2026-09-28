import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/app_theme.dart';
import 'core/app_routes.dart';
import 'features/shell/shell_screen.dart';

class VoilaNovaApp extends ConsumerWidget {
  const VoilaNovaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'VOILANOVA - Premium Marketplace',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => const ShellScreen(),
        AppRoutes.seller: (_) => const ShellScreen(initialIndex: 5),
        AppRoutes.admin: (_) => const ShellScreen(initialIndex: 6),
      },
      builder: (context, child) {
        return child ??
            const Scaffold(
              body: Center(
                child: Text('Page not found'),
              ),
            );
      },
    );
  }
}
