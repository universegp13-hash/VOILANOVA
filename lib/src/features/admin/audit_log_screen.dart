import 'package:flutter/material.dart';
import '../../models/audit_log.dart';

class AuditLogScreen extends StatelessWidget {
  final List<AuditLog> auditLogs;

  const AuditLogScreen({super.key, required this.auditLogs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: ListView.builder(
        itemCount: auditLogs.length,
        itemBuilder: (context, index) {
          final log = auditLogs[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(log.message),
              subtitle: Text(log.timestamp),
              leading: const Icon(Icons.timeline),
            ),
          );
        },
      ),
    );
  }
}
