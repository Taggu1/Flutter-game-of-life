import 'package:flutter/material.dart';
import 'package:flutter_game_of_life/game_of_life_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
          body: GameOfLifeWidget(
        width: double.infinity,
        height: double.infinity,
      )),
    );
  }
}
