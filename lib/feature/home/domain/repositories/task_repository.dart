import 'package:dartz/dartz.dart' hide Task;
import 'package:my_todo/core/error/failures.dart';
import 'package:my_todo/feature/home/domain/entities/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<Task>>> getTasks();
  Future<Either<Failure, Task>> addTask(Task task);
  Future<Either<Failure, Task>> updateTask(Task task);
  Future<Either<Failure, void>> deleteTask(String id);
}
