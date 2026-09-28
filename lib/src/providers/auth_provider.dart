import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/profile.dart';

final authProfileProvider = StateProvider<Profile>((ref) {
  return Profile(
    id: 'customer-uuid-001',
    email: 'hello@voilanova.app',
    fullName: 'Nova Shopper',
    role: 'customer',
    createdAt: DateTime.now(),
  );
});

final authRoleProvider =
    Provider<String>((ref) => ref.watch(authProfileProvider).role);

final authIsSellerProvider =
    Provider<bool>((ref) => ref.watch(authRoleProvider) == 'seller');
final authIsAdminProvider =
    Provider<bool>((ref) => ref.watch(authRoleProvider) == 'admin');
