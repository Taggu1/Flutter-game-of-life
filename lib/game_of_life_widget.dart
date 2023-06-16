import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_game_of_life/game_board.dart';
import 'package:flutter_game_of_life/game_of_life.dart';
import 'package:touchable/touchable.dart';

import 'board_painter.dart';

class GameOfLifeWidget extends StatefulWidget {
  const GameOfLifeWidget({super.key});

  @override
  _GameOfLifeWidgetState createState() => _GameOfLifeWidgetState();
}

class _GameOfLifeWidgetState extends State<GameOfLifeWidget> {
  final _game = GameOfLife();

  late Size _cellSize;
  @override
  void initState() {
    super.initState();
    //Fullscreen display (still including appbar)
    _game.resetWorld();
  }

  void _toggleGame() {
    setState(() {
      _game.toggleGame();
    });
  }

  void _resetGame() {
    setState(() {
      _game.resetWorld();
    });
  }

  @override
  Widget build(BuildContext contGameOfLifeext) {
    final screenSize = MediaQuery.of(context).size;
    _cellSize = Size(screenSize.width / GameOfLife.rowLength,
        (screenSize.height) / (GameOfLife.worldSize / GameOfLife.rowLength));

    return Scaffold(
      body: StreamBuilder<double>(
        stream: _game.stateController.stream,
        builder: (context, snapshot) {
          print(snapshot);
          return GameBoard(
            game: _game,
            cellSize: _cellSize,
          );
        },
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        children: [
          FloatingActionButton.small(
            onPressed: _toggleGame,
            tooltip: 'Start/Stop',
            child: _game.running
                ? const Icon(Icons.pause)
                : const Icon(Icons.play_arrow),
          ),
          FloatingActionButton.small(
            heroTag: null,
            onPressed: _resetGame,
            child: const Icon(Icons.restart_alt),
          ),
        ],
      ),
    );
  }
}


// FloatingActionButton(
//         onPressed: _toggleGame,
//         tooltip: 'Start/Stop',
//         child: _game.running
//             ? const Icon(Icons.pause)
//             : const Icon(Icons.play_arrow),
//       ),