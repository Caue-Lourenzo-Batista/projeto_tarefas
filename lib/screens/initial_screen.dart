import 'package:flutter/material.dart';
import 'package:projeto_tarefas/Screens/form_screen.dart';
import 'package:projeto_tarefas/Widgets/tasks.dart';
import 'package:projeto_tarefas/data/task_dao.dart';
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
        leading: Container(),
        actions: [IconButton(onPressed: () {setState(() {});}, icon: Icon(Icons.refresh))],
        title: const Text("Tarefas"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 90),
        child: FutureBuilder<List<Task>>(
            future: TaskDao().findAll(),
            builder: (context, snapshot) {
              List<Task>? itens = snapshot.data;

              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        Text('Carregando...'),
                      ],
                    ),
                  );

                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('Carregando...'),
                      ],
                    ),
                  );

                case ConnectionState.active:
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('Carregando...'),
                      ],
                    ),
                  );

                case ConnectionState.done:
                  if (snapshot.hasData && itens != null) {
                    if (itens.isNotEmpty) {
                      return ListView.builder(
                          itemCount: itens.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Task tarefa = itens[index];
                            return tarefa;
                          });
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.error_outline_outlined,
                            size: 130,
                            color: Colors.white,
                          ),
                          Text(
                            'Não ha nenhuma tarefa',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Text('Erro ao conectar ao banco de dados');
              }
              return Text('Erro desconhecido');
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => form_screen(taskContext: context),
            ),
          ).then((value) => setState(() {
                print('Recarregando a pagina');
              })
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
