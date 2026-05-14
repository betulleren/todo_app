import 'package:flutter/material.dart';
import 'screens/todo_list_screen.dart';

void main() => runApp(const PinkTodoApp());

class PinkTodoApp extends StatefulWidget {
  const PinkTodoApp({super.key});

  @override
  State<PinkTodoApp> createState() => _PinkTodoAppState();
}

class _PinkTodoAppState extends State<PinkTodoApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink, brightness: Brightness.light),
        scaffoldBackgroundColor: const Color(0xFFFFF0F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink, brightness: Brightness.dark),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink.shade900,
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
        ),
      ),
      home: TodoListScreen(
        isDarkMode: _themeMode == ThemeMode.dark,
        onThemeChanged: toggleTheme,
      ),
    );
  }
}