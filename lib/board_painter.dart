import 'package:flutter/material.dart';
import 'package:flutter_game_of_life/game_of_life.dart';
import 'package:touchable/touchable.dart';

class BoardPainter extends CustomPainter {
  final BuildContext context;

  final GameOfLife game;

  final Paint paintSetting = Paint()..strokeWidth = 1;

  BoardPainter(
    this.context, {
    required this.game,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final touchyCanvas = TouchyCanvas(context, canvas);
    for (int i = 0; i < game.columnsCount; i++) {
      for (int j = 0; j < game.rowsCount; j++) {
        final alive = game.world[i][j];
        final left = i * game.cellSize;
        final top = j * game.cellSize;
        paintSetting.color = alive ? Colors.white : Colors.black;

        touchyCanvas.drawRect(
            Rect.fromLTWH(
              left,
              top,
              game.cellSize - 1,
              game.cellSize - 1,
            ),
            paintSetting, onTapDown: (s) {
          game.changeCellState(i, j);
        });
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
