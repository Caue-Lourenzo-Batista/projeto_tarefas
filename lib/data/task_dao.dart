import 'package:projeto_tarefas/Widgets/tasks.dart';
import 'package:projeto_tarefas/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  //----------------Criando o Banco de Dados-----------------

  static const String tableSql = 'CREATE TABLE taskTable(name TEXT, difficulty INTEGER, image TEXT)';

  //--------Criando os métodos do CRUD para o banco---------

  save(Task tarefa) async {
    print('Acessando o save');

    final Database bancoDados = await getDatabase();
    var itemExist = await find(tarefa.tarefa);
    Map<String, dynamic> taskMap = toMap(tarefa);

    if (itemExist.isEmpty) {
      print('A tarefa não existe');

      return await bancoDados.insert('taskTable', taskMap);
    } else {
      print('A terefa já existia');

      return await bancoDados.update('taskTable', taskMap,
          where: 'name = ?', whereArgs: [tarefa.tarefa]);
    }
  }

  delete(String nomeTarefa) async {
    print('Acessando o delete');

    final Database bancoDados = await getDatabase();

    return bancoDados
        .delete('taskTable', where: 'name = ?', whereArgs: [nomeTarefa]);
  }

  Future<List<Task>> find(String nomeTarefa) async {
    print('Acessando o find');

    final Database bancoDados = await getDatabase();

    final List<Map<String, dynamic>> result = await bancoDados
        .query('taskTable', where: 'name = ?', whereArgs: [nomeTarefa]);

    print('Procurando tarefa... ${toList(result)}');

    return toList(result);
  }

  Future<List<Task>> findAll() async {
    print('Acessando o findALl');

    final Database bancoDados = await getDatabase();

    final List<Map<String, dynamic>> result = await bancoDados.query('taskTable');

    print('Procurando dados no banco... $result');

    return toList(result);
  }
}


//----------Metodo toList para transformas listas em tarefas-------------
List<Task> toList(List<Map<String, dynamic>> mapaTarefas) {
  final List<Task> tarefas = [];

  for (Map<String, dynamic> linha in mapaTarefas) {
    final Task tarefa =
        Task(linha['name'], linha['image'], linha['difficulty']);
    tarefas.add(tarefa);
  }

  print('lista de tarefas $tarefas');

  return tarefas;
}

//----------Metodo toMap para transformas tarefas em lista-------------
Map<String, dynamic> toMap(Task tarefa) {
  print('Convertendo tarefa em Map');
  final Map<String, dynamic> mapaTarefas = {};
  mapaTarefas['name'] = tarefa.tarefa;
  mapaTarefas['difficulty'] = tarefa.difficulty;
  mapaTarefas['image'] = tarefa.foto;

  print('Mapa de tarefas transformada $mapaTarefas');

  return mapaTarefas;
}
