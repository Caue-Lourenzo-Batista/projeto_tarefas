import 'package:flutter/material.dart';
import 'package:projeto_tarefas/Screens/initial_screen.dart';
import 'package:projeto_tarefas/data/task_inherrited.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Projeto Tarefas',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: TaskInherrited(child: const initialScreen()),
    );
  }
}
