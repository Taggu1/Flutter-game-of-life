import 'package:flutter/material.dart';
import 'package:flutter_game_of_life/board_painter.dart';
import 'package:flutter_game_of_life/game_of_life.dart';
import 'package:flutter_game_of_life/game_of_life_widget.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: GameOfLifeWidget(
        height: 500,
        width: size.width,
      ),
    );
  }
}
