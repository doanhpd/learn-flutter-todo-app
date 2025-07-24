import 'package:my_todo/feature/home/data/models/tag_model.dart';
import 'package:my_todo/feature/home/domain/entities/task.dart';
import 'package:uuid/uuid.dart';

class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.title,
    required super.dueDate,
    required super.dueTime,
    super.isCompleted = false,
    super.tag,
    super.priority = 1,
  });

  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      dueDate: task.dueDate,
      dueTime: task.dueTime,
      isCompleted: task.isCompleted,
      tag: task.tag != null ? TagModel.fromEntity(task.tag!) : null,
      priority: task.priority,
    );
  }

  // For simplicity, we'll use a basic map for 'database' simulation.
  // In a real app, this would be `fromMap` / `toJson` for persistence.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'dueDate': dueDate.toIso8601String(),
      'dueTime': dueTime.toIso8601String(),
      'isCompleted': isCompleted,
      'tag': tag != null ? (tag as TagModel).toMap() : null,
      'priority': priority,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      title: map['title'] as String,
      dueDate: DateTime.parse(map['dueDate'] as String),
      dueTime: DateTime.parse(map['dueTime'] as String),
      isCompleted: map['isCompleted'] as bool,
      tag: map['tag'] != null
          ? TagModel.fromMap(map['tag'] as Map<String, dynamic>)
          : null,
      priority: map['priority'] as int,
    );
  }

  // Helper to generate a new ID
  static String generateId() => const Uuid().v4();
}
