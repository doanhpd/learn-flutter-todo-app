import 'package:my_todo/core/error/failures.dart';
import 'package:my_todo/feature/home/data/datasource/task_local_data_source.dart';
import 'package:my_todo/feature/home/data/models/task_model.dart';
import 'package:my_todo/feature/home/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart' hide Task;
import 'package:my_todo/feature/home/domain/entities/task.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Task>> addTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      final result = await localDataSource.addTask(taskModel);
      return Right(result);
    } on LocalDatabaseFailure catch (e) {
      return Left(LocalDatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String id) async {
    try {
      await localDataSource.deleteTask(id);
      return const Right(null);
    } on LocalDatabaseFailure catch (e) {
      return Left(LocalDatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Task>>> getTasks() async {
    try {
      final result = await localDataSource.getTasks();
      return Right(result);
    } on LocalDatabaseFailure catch (e) {
      return Left(LocalDatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Task>> updateTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      final result = await localDataSource.updateTask(taskModel);
      return Right(result);
    } on LocalDatabaseFailure catch (e) {
      return Left(LocalDatabaseFailure(e.message));
    }
  }
}
