import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo/core/constants/app_color.dart';
import 'package:my_todo/feature/home/presentation/pages/home_screen.dart';

void main() {
  runApp(
    // Riverpod's ProviderScope is essential for managing providers.
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark, // Overall dark theme
        scaffoldBackgroundColor: AppColors.primaryDark,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.textLight,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.textLight),
          bodyMedium: TextStyle(color: AppColors.textLight),
        ),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accentPurple,
          background: AppColors.primaryDark,
          surface: AppColors.cardDark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
