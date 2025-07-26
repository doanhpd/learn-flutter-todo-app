import 'package:my_todo/core/error/failures.dart';
import 'package:my_todo/feature/home/data/models/tag_model.dart';
import 'package:my_todo/feature/home/data/models/task_model.dart';
import 'package:my_todo/feature/home/domain/entities/task.dart';

abstract class TaskLocalDataSource {
  Future<List<Task>> getTasks();
  Future<TaskModel> addTask(TaskModel task);
  Future<TaskModel> updateTask(TaskModel task);
  Future<void> deleteTask(String taskId);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  // This class would implement the methods to interact with local storage
  // For example, using shared preferences, SQLite, or any local database solution.
  // Simulate a local database with an in-memory list
  final List<TaskModel> _tasks = [
    TaskModel(
      id: TaskModel.generateId(),
      title: 'Do Math Homework',
      dueDate: DateTime.now(),
      dueTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        16,
        45,
      ),
      tag: TagModel.predefinedTags[0], // University
      priority: 1,
    ),
    TaskModel(
      id: TaskModel.generateId(),
      title: 'Take out dogs',
      dueDate: DateTime.now(),
      dueTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        18,
        20,
      ),
      tag: TagModel.predefinedTags[1], // Home
      priority: 2,
    ),
    TaskModel(
      id: TaskModel.generateId(),
      title: 'Business meeting with CEO',
      dueDate: DateTime.now(),
      dueTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        8,
        15,
      ),
      tag: TagModel.predefinedTags[2], // Work
      priority: 3,
    ),
    TaskModel(
      id: TaskModel.generateId(),
      title: 'Buy Grocery',
      dueDate: DateTime.now(),
      dueTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        16,
        45,
      ),
      isCompleted: true,
      priority: 1,
    ),
  ];
  @override
  Future<List<Task>> getTasks() {
    // Implementation to fetch tasks from local storage
    try {
      // Simulate network/database delay
      return Future.delayed(
        const Duration(milliseconds: 500),
        () => List.from(_tasks),
      );
    } catch (e) {
      throw LocalDatabaseFailure('Failed to retrieve tasks: $e');
    }
  }

  @override
  Future<TaskModel> addTask(TaskModel task) {
    // Implementation to add a task to local storage
    try {
      _tasks.add(task);
      return Future.value(task);
    } catch (e) {
      throw LocalDatabaseFailure('Failed to add task: $e');
    }
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) {
    // Implementation to update a task in local storage
    try {
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
        return Future.value(task);
      } else {
        throw LocalDatabaseFailure('Task not found for update.');
      }
    } catch (e) {
      throw LocalDatabaseFailure('Failed to update task: $e');
    }
  }

  @override
  Future<void> deleteTask(String taskId) {
    // Implementation to delete a task from local storage
    try {
      _tasks.removeWhere((task) => task.id == taskId);
      return Future.value();
    } catch (e) {
      throw LocalDatabaseFailure('Failed to delete task: $e');
    }
  }
}
