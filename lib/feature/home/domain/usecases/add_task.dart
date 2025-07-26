import 'package:my_todo/core/error/failures.dart';
import 'package:my_todo/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:my_todo/feature/home/domain/entities/task.dart';
import 'package:my_todo/feature/home/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart' hide Task;

class AddTaskUseCase implements UseCase<void, AddTaskParams> {
  final TaskRepository _taskRepository;

  AddTaskUseCase(this._taskRepository);

  @override
  Future<Either<Failure, Task>> call(AddTaskParams params) async {
    return await _taskRepository.addTask(params.task);
  }
}

class AddTaskParams extends Equatable {
  final Task task;

  const AddTaskParams({required this.task});

  @override
  List<Object?> get props => [task];
}
