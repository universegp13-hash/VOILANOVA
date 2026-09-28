import 'package:flutter/material.dart';

class CategoryBadge extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const CategoryBadge(
      {super.key,
      required this.label,
      this.active = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: active ? Theme.of(context).colorScheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(label,
            style: TextStyle(
                color: active ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}
