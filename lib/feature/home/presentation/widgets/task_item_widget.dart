import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_todo/core/constants/app_color.dart';
import 'package:my_todo/core/constants/app_icons.dart';
import 'package:my_todo/feature/home/domain/entities/task.dart';
import 'package:my_todo/feature/home/presentation/widgets/tag_widget.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;
  final ValueChanged<Task> onToggleComplete;

  const TaskItemWidget({
    super.key,
    required this.task,
    required this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardDark,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            InkWell(
              onTap: () => onToggleComplete(task),
              borderRadius: BorderRadius.circular(12),
              child: Icon(
                task.isCompleted
                    ? AppIcons.radioChecked
                    : AppIcons.radioUnchecked,
                color: task.isCompleted
                    ? AppColors.accentPurple
                    : AppColors.textGrey,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      color: AppColors.textLight,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      decorationColor: AppColors.textGrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Today At ${DateFormat('HH:mm').format(task.dueTime)}',
                    style: const TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (task.tag != null) ...[
              TagWidget(tag: task.tag!),
              const SizedBox(width: 8),
            ],
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'B ${task.priority}',
                style: const TextStyle(
                  color: AppColors.textLight,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
