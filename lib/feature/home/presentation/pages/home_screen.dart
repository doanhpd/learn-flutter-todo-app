import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo/core/constants/app_color.dart';
import 'package:my_todo/core/constants/app_icons.dart';
import 'package:my_todo/feature/home/data/models/tag_model.dart';
import 'package:my_todo/feature/home/data/models/task_model.dart';
import 'package:my_todo/feature/home/domain/entities/task.dart';
import 'package:my_todo/feature/home/presentation/providers/home_page_provider.dart';
import 'package:my_todo/feature/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:my_todo/feature/home/presentation/widgets/task_item_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isCompletedSectionExpanded = false;
  int _selectedBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    final homeNotifier = ref.read(homeProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(AppIcons.menu, color: AppColors.textLight),
          onPressed: () {
            // Handle drawer open
          },
        ),
        title: const Text(
          'Index',
          style: TextStyle(
            color: AppColors.textLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: Image.asset(
                'assets/profile_pic.png',
              ).image, // Add this image to assets
              radius: 18,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.cardDark,
                hintText: 'Search for your task...',
                hintStyle: const TextStyle(color: AppColors.textGrey),
                prefixIcon: const Icon(
                  AppIcons.search,
                  color: AppColors.textGrey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
              style: const TextStyle(color: AppColors.textLight),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Today',
                      style: TextStyle(
                        color: AppColors.textLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      AppIcons.arrowDown,
                      color: AppColors.textLight,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            homeState.when(
              data: (tasks) {
                final activeTasks = homeNotifier.filteredTasks;
                final completedTasks = homeNotifier.completedTasks;

                return Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ...activeTasks.map(
                        (task) => TaskItemWidget(
                          task: task,
                          onToggleComplete: (t) =>
                              homeNotifier.toggleTaskCompletion(t),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Completed Section
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isCompletedSectionExpanded =
                                !_isCompletedSectionExpanded;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Completed (${completedTasks.length})',
                                style: const TextStyle(
                                  color: AppColors.textGrey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                _isCompletedSectionExpanded
                                    ? Icons.keyboard_arrow_up
                                    : AppIcons.arrowDown,
                                color: AppColors.textGrey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_isCompletedSectionExpanded)
                        ...completedTasks.map(
                          (task) => TaskItemWidget(
                            task: task,
                            onToggleComplete: (t) =>
                                homeNotifier.toggleTaskCompletion(t),
                          ),
                        ),
                    ],
                  ),
                );
              },
              loading: () => const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.accentPurple,
                  ),
                ),
              ),
              error: (err, stack) => Expanded(
                child: Center(
                  child: Text(
                    'Error: $err',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add New Task functionality
          homeNotifier.addTask(
            Task(
              id: TaskModel.generateId(),
              title: 'New Task Added',
              dueDate: DateTime.now(),
              dueTime: DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                10,
                0,
              ),
              tag: TagModel.predefinedTags[0],
              priority: 1,
            ),
          );
        },
        backgroundColor: AppColors.accentPurple,
        shape: const CircleBorder(),
        child: const Icon(AppIcons.add, color: AppColors.textLight, size: 30),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedBottomNavIndex,
        onItemSelected: (index) {
          if (index == 2) return; // Ignore tap on the "hidden" FAB item
          setState(() {
            _selectedBottomNavIndex = index;
          });
          // Handle navigation
        },
      ),
    );
  }
}
