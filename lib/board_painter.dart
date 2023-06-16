import 'package:flutter/material.dart';
import 'package:flutter_game_of_life/game_of_life.dart';
import 'package:touchable/touchable.dart';

class BoardPainter extends CustomPainter {
  final Size cellSize;
  final BuildContext context;
  final int rowLength;
  final GameOfLife game;
  final int cellMargin;

  final Paint paintSetting = Paint()..strokeWidth = 1;

  BoardPainter(
    this.context, {
    required this.game,
    required this.cellSize,
    required this.rowLength,
    required this.cellMargin,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final touchycanvas = TouchyCanvas(context, canvas);
    int rowCounter = 0;
    final world = game.world;
    for (var i = 0; i < world.length; i++) {
      if (i != 0 && i % rowLength == 0) rowCounter++;

      final left =
          ((i - (rowCounter * rowLength)) * cellSize.width) + cellMargin;
      final top = (cellSize.height * rowCounter) + cellMargin;
      final marginedSize = Size(
          cellSize.width - 2 * cellMargin, cellSize.height - 2 * cellMargin);
      paintSetting.color = world[i] ? Colors.white : Colors.black;
      touchycanvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(left, top, size.width, size.height),
            const Radius.circular(0),
          ),
          paintSetting, onTapDown: (s) {
        game.changeCellState(i);
      });
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
