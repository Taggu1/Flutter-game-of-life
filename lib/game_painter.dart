import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

import 'game_of_life.dart';

class GamePainter extends CustomPainter {
  final Game game;
  final BuildContext context;

  GamePainter(
    this.context,
    this.game,
  );

  @override
  void paint(Canvas canvas, Size size) {
    // Define a paint object
    final myCanvas = TouchyCanvas(context, canvas);
    final linesPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.black;

    final boxPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;

    final dx = size.width / game.grid.xCount;
    final dy = size.height / game.grid.yCount;

    // Active cells
    for (var entry in game.grid.field.entries) {
      final point = entry.key;
      final rect = Rect.fromLTWH(point.x * dx, point.y * dy, dx, dy);
      myCanvas.drawRect(
          rect, boxPaint..color = entry.value ? Colors.blue : Colors.red,
          onTapDown: (s) {
        print("FUCK");
        game.grid.field[point] = !entry.value;
      });
    }

    // grid
    for (var x = 0; x <= game.grid.xCount; x++) {
      for (var y = 0; y <= game.grid.yCount; y++) {
        final xPath = Path();
        xPath.moveTo(x * dx, 0);
        xPath.lineTo(x * dx, size.height);

        final yPath = Path();
        yPath.moveTo(0, y * dy);
        yPath.lineTo(size.width, y * dy);

        myCanvas.drawPath(
          xPath,
          linesPaint,
        );
        myCanvas.drawPath(yPath, linesPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
