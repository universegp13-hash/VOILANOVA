import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../models/audit_log.dart';
import '../core/mock_data.dart';

final adminQueueProvider = StateProvider<List<Product>>((ref) {
  return kMockProducts
      .where((product) => product.approvalStatus == 'pending')
      .toList();
});

final adminAuditProvider = StateProvider<List<AuditLog>>((ref) {
  return kAuditLogs;
});
