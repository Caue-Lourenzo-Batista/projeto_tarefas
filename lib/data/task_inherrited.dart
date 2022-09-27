import 'package:flutter/material.dart';
import '../Widgets/tasks.dart';

class TaskInherrited extends InheritedWidget {
  TaskInherrited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
    Task('Jogar VideoGame', 'assets/images/videogame.jpg', 2),
    Task('Aprender Flutter', 'assets/images/flutter.png', 3),
    Task('Praticar Exercícios', 'assets/images/academia.jpg', 1),
    Task('Ler um livro', 'assets/images/ler.jpg', 4),
    Task('Meditar', 'assets/images/meditar.jpg', 5),
  ];

  void newTask(String nome, String foto, int dificuldade){
    taskList.add(Task(nome, foto, dificuldade));
  }

  static TaskInherrited of(BuildContext context) {
    final TaskInherrited? result = context.dependOnInheritedWidgetOfExactType<TaskInherrited>();
    assert(result != null, 'No TaskInherrited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherrited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
