import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(authProfileProvider);
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Header
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Account',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
          // Profile Card
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.6),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person_outline,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.fullName,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              profile.email,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                profile.role.toUpperCase(),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Settings Section
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Settings',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _settingsTile(
                    context,
                    Icons.notifications_outlined,
                    'Push Notifications',
                    'Manage your notification preferences',
                  ),
                  _settingsTile(
                    context,
                    Icons.lock_outline,
                    'Password & Security',
                    'Change password and security settings',
                  ),
                  _settingsTile(
                    context,
                    Icons.location_on_outlined,
                    'Addresses',
                    'Manage your shipping addresses',
                  ),
                  _settingsTile(
                    context,
                    Icons.payment_outlined,
                    'Payment Methods',
                    'Manage your payment information',
                  ),
                  _settingsTile(
                    context,
                    Icons.help_outline,
                    'Help & Support',
                    'Get help with your account',
                  ),
                  _settingsTile(
                    context,
                    Icons.logout_outlined,
                    'Logout',
                    'Sign out of your account',
                    isDangerous: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle, {
    bool isDangerous = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          icon,
          color:
              isDangerous ? Colors.red : Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isDangerous ? Colors.red : null,
              ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.grey.shade400,
        ),
        onTap: () {
          // Handle tap
        },
      ),
    );
  }
}
