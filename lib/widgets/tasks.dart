import 'package:flutter/material.dart';
import 'package:projeto_tarefas/data/task_dao.dart';

import 'difficulty.dart';

class Task extends StatefulWidget {
  final String tarefa;
  final String foto;
  final int difficulty;
  int nivel = 0;
  int state = 0;

  Task(this.tarefa, this.foto, this.difficulty, {Key? key})
      : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  List<Color> colors = [
    Colors.brown,
    Colors.yellow,
    Colors.blue,
    Colors.pink,
    Colors.blueGrey
  ];

  bool assetsOrNetwork() {
    if (widget.foto.contains('http')) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: colors[widget.state],
            ),
            height: 130,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black38,
                      ),
                      width: 80,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: assetsOrNetwork()
                            ? Image.asset(
                                widget.foto,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                widget.foto,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            widget.tarefa,
                            style: const TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Difficulty(
                          levelDificulty: widget.difficulty,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        right: 10.0,
                      ),
                      child: Column(
                        children: [
                          ElevatedButton(

                            onPressed: () {
                              setState(() {
                                TaskDao().delete(widget.tarefa);
                              });
                            },
                            child: SizedBox(
                                height: 25,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.delete_forever),
                                  ],
                                )),
                          ),

                          ElevatedButton(

                            onPressed: () {
                              setState(() {
                                if (widget.nivel < widget.difficulty * 10) {
                                  widget.nivel++;
                                } else if (widget.state == colors.length - 1) {
                                  widget.nivel++;
                                } else {
                                  widget.nivel = 0;
                                  widget.state++;
                                }
                              });
                            },
                            child: SizedBox(
                                height: 25,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.arrow_circle_up_rounded),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.difficulty > 0)
                            ? (widget.nivel / widget.difficulty) / 10
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, top: 5.0),
                    child: Text(
                      "Nivel: ${widget.nivel}",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
