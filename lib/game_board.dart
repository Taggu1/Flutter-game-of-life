import 'package:flutter/material.dart';
import 'package:flutter_game_of_life/board_painter.dart';
import 'package:flutter_game_of_life/game_of_life.dart';
import 'package:touchable/touchable.dart';

class GameBoard extends StatelessWidget {
  final GameOfLife game;
  final Size cellSize;

  const GameBoard({
    super.key,
    required this.game,
    required this.cellSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CanvasTouchDetector(
              builder: (context) {
                return CustomPaint(
                  painter: BoardPainter(
                    context,
                    cellMargin: GameOfLife.cellMargin,
                    cellSize: cellSize,
                    rowLength: GameOfLife.rowLength,
                    game: game,
                  ),
                );
              },
              gesturesToOverride: const [
                GestureType.onTapDown,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
