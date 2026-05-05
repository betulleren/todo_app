import 'package:flutter/material.dart';
import 'screens/todo_list_screen.dart';

void main() => runApp(const PinkTodoApp());

class PinkTodoApp extends StatelessWidget {
  const PinkTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
        ),
      ),
      home: const TodoListScreen(),
    );
  }
}