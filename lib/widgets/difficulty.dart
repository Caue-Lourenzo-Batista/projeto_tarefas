import 'package:flutter/material.dart';

class Difficulty extends StatelessWidget {

  final int levelDificulty;

  const Difficulty({
    required this.levelDificulty,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 15,
          color: (levelDificulty >= 1) ? Colors.blue : Colors.blue[100],
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (levelDificulty >= 2) ? Colors.blue : Colors.blue[100],
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (levelDificulty >= 3) ? Colors.blue : Colors.blue[100],
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (levelDificulty >= 4) ? Colors.blue : Colors.blue[100],
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (levelDificulty >= 5) ? Colors.blue : Colors.blue[100],
        ),
      ],
    );
  }
}