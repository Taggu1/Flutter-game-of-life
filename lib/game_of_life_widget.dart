import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_game_of_life/game_of_life.dart';
import 'package:touchable/touchable.dart';

import 'board_painter.dart';

class GameOfLifeWidget extends StatefulWidget {
  final double width;
  final double height;
  const GameOfLifeWidget({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  State<GameOfLifeWidget> createState() => _GameOfLifeWidgetState();
}

class _GameOfLifeWidgetState extends State<GameOfLifeWidget>
    with SingleTickerProviderStateMixin {
  late GameOfLife game;

  late Timer timer;

  double get width => widget.width;
  double get height => widget.height;
  @override
  void initState() {
    super.initState();

    game = GameOfLife(
      cellSize: 20,
      columnsCount: (width / 20).floor(),
      rowsCount: (height / 20).floor(),
    );

    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        game.compute();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height,
          width: width,
          child: CanvasTouchDetector(
            builder: (context) {
              return CustomPaint(
                painter: BoardPainter(context, game: game),
              );
            },
            gesturesToOverride: const [
              GestureType.onTapDown,
            ],
          ),
        ),
        const SizedBox(
          height: 23,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                game.switchGameState();
                setState(() {});
              },
              child: Text(
                game.playing ? "Stop" : "Start",
              ),
            ),
            SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () {
                game.reset();
                setState(() {});
              },
              child: const Text(
                "Reset",
              ),
            ),
          ],
        )
      ],
    );
  }
}
