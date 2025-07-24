import 'package:equatable/equatable.dart';
import 'package:my_todo/feature/home/domain/entities/tag.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final DateTime dueDate;
  final DateTime dueTime;
  final bool isCompleted;
  final Tag? tag;
  final int priority; // e.g., 1, 2, 3

  const Task({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.dueTime,
    this.isCompleted = false,
    this.tag,
    this.priority = 1,
  });

  Task copyWith({
    String? id,
    String? title,
    DateTime? dueDate,
    DateTime? dueTime,
    bool? isCompleted,
    Tag? tag,
    int? priority,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      dueTime: dueTime ?? this.dueTime,
      isCompleted: isCompleted ?? this.isCompleted,
      tag: tag ?? this.tag,
      priority: priority ?? this.priority,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    dueDate,
    dueTime,
    isCompleted,
    tag,
    priority,
  ];
}
