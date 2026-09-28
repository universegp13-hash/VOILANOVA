import 'package:flutter/material.dart';

class AnalyticsCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color accentColor;

  const AnalyticsCard(
      {super.key,
      required this.title,
      required this.value,
      required this.subtitle,
      required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Text(value,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: accentColor)),
            const SizedBox(height: 8),
            Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }
}
