import 'package:flutter/material.dart';
import 'package:my_todo/feature/home/domain/entities/tag.dart';

class TagWidget extends StatelessWidget {
  final Tag tag;

  const TagWidget({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tag.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (tag.icon != null) ...[
            Icon(tag.icon, size: 16, color: tag.textColor),
            const SizedBox(width: 4),
          ],
          Text(
            tag.name,
            style: TextStyle(
              color: tag.textColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
