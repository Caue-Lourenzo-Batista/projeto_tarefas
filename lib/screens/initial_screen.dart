import 'package:flutter/material.dart';
import 'package:projeto_tarefas/Screens/form_screen.dart';
import 'package:projeto_tarefas/Widgets/tasks.dart';
import '../data/task_inherrited.dart';

class initialScreen extends StatefulWidget {
  const initialScreen({Key? key}) : super(key: key);

  @override
  State<initialScreen> createState() => _initialScreenState();
}

class _initialScreenState extends State<initialScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Tarefas"),
      ),
      body: ListView(
        children: TaskInherrited.of(context).taskList,
        padding: const EdgeInsets.only(top: 8, bottom: 90),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => form_screen(taskContext: context),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
