import 'package:flutter/material.dart';
import 'package:my_todo/core/constants/app_color.dart';
import 'package:my_todo/core/constants/app_icons.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onItemSelected,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.primaryDark,
      selectedItemColor: AppColors.accentPurple,
      unselectedItemColor: AppColors.textGrey,
      selectedLabelStyle: const TextStyle(fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      items: const [
        BottomNavigationBarItem(icon: Icon(AppIcons.index), label: 'Index'),
        BottomNavigationBarItem(
          icon: Icon(AppIcons.calendar),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle, size: 0), // Hidden icon for FAB position
          label: '',
        ),
        BottomNavigationBarItem(icon: Icon(AppIcons.focus), label: 'Focus'),
        BottomNavigationBarItem(icon: Icon(AppIcons.profile), label: 'Profile'),
      ],
    );
  }
}
