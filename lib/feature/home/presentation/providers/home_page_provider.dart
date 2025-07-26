import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo/core/usecases/usecase.dart';
import 'package:my_todo/feature/home/data/datasource/task_local_data_source.dart';
import 'package:my_todo/feature/home/data/repositories/task_repository_impl.dart';
import 'package:my_todo/feature/home/domain/entities/task.dart';
import 'package:my_todo/feature/home/domain/usecases/add_task.dart';
import 'package:my_todo/feature/home/domain/usecases/get_task.dart';
import 'package:my_todo/feature/home/domain/usecases/update_task.dart';

enum TaskFilter { today, upcoming, completed }

class HomeNotifier extends StateNotifier<AsyncValue<List<Task>>> {
  final GetTaskUseCase _getTasksUseCase;
  final AddTaskUseCase _addTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;

  HomeNotifier(
    this._getTasksUseCase,
    this._addTaskUseCase,
    this._updateTaskUseCase,
  ) : super(const AsyncValue.loading()) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    state = const AsyncValue.loading();
    final result = await _getTasksUseCase(NoParams());
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (tasks) => state = AsyncValue.data(tasks),
    );
  }

  Future<void> addTask(Task task) async {
    state = const AsyncValue.loading(); // Show loading while adding
    final result = await _addTaskUseCase(AddTaskParams(task: task));
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (newTask) {
        // Optimistically update or reload
        // For simplicity, we'll reload all tasks
        _loadTasks();
      },
    );
  }

  Future<void> toggleTaskCompletion(Task task) async {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    // Optimistic update
    state.whenData((tasks) {
      final newTasks = tasks
          .map((t) => t.id == task.id ? updatedTask : t)
          .toList();
      state = AsyncValue.data(newTasks);
    });

    final result = await _updateTaskUseCase(
      UpdateTaskParams(task: updatedTask),
    );
    result.fold(
      (failure) {
        // Revert if update fails
        state.whenData((tasks) {
          final originalTasks = tasks
              .map((t) => t.id == task.id ? task : t)
              .toList();
          state = AsyncValue.data(originalTasks);
        });
        // Optionally show a snackbar/error message
      },
      (success) {
        // No need to do anything, state is already updated optimistically
      },
    );
  }

  // Filter logic for UI
  List<Task> get filteredTasks {
    return state.when(
      data: (tasks) {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        // Filter out completed tasks from the main list, they will be in a separate section
        return tasks.where((task) => !task.isCompleted).toList();
      },
      loading: () => [],
      error: (err, stack) => [],
    );
  }

  List<Task> get completedTasks {
    return state.when(
      data: (tasks) {
        return tasks.where((task) => task.isCompleted).toList();
      },
      loading: () => [],
      error: (err, stack) => [],
    );
  }
}

// Providers for dependencies (Dependency Injection with Riverpod)
final taskLocalDataSourceProvider = Provider(
  (ref) => TaskLocalDataSourceImpl(),
);

final taskRepositoryProvider = Provider(
  (ref) => TaskRepositoryImpl(
    localDataSource: ref.watch(taskLocalDataSourceProvider),
  ),
);

final getTasksUseCaseProvider = Provider(
  (ref) => GetTaskUseCase(ref.watch(taskRepositoryProvider)),
);

final addTaskUseCaseProvider = Provider(
  (ref) => AddTaskUseCase(ref.watch(taskRepositoryProvider)),
);

final updateTaskUseCaseProvider = Provider(
  (ref) => UpdateTaskUseCase(ref.watch(taskRepositoryProvider)),
);

final homeProvider =
    StateNotifierProvider<HomeNotifier, AsyncValue<List<Task>>>((ref) {
      return HomeNotifier(
        ref.watch(getTasksUseCaseProvider),
        ref.watch(addTaskUseCaseProvider),
        ref.watch(updateTaskUseCaseProvider),
      );
    });
