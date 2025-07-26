import 'package:my_todo/core/error/failures.dart';
import 'package:my_todo/core/usecases/usecase.dart';
import 'package:my_todo/feature/home/domain/entities/task.dart';
import 'package:my_todo/feature/home/domain/repositories/task_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart' hide Task;

class UpdateTaskUseCase implements UseCase<Task, UpdateTaskParams> {
  final TaskRepository _taskRepository;

  UpdateTaskUseCase(this._taskRepository);

  @override
  Future<Either<Failure, Task>> call(UpdateTaskParams params) async {
    return await _taskRepository.updateTask(params.task);
  }
}

class UpdateTaskParams extends Equatable {
  final Task task;

  const UpdateTaskParams({required this.task});

  @override
  List<Object?> get props => [task];
}
