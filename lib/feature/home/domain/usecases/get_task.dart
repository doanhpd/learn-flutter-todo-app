import 'package:my_todo/core/error/failures.dart';
import 'package:my_todo/core/usecases/usecase.dart';
import 'package:my_todo/feature/home/domain/entities/task.dart';
import 'package:my_todo/feature/home/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart' hide Task;

class GetTaskUseCase implements UseCase<List<Task>, NoParams> {
  final TaskRepository repository;

  GetTaskUseCase(this.repository);

  @override
  Future<Either<Failure, List<Task>>> call(NoParams params) async {
    return await repository.getTasks();
  }
}
