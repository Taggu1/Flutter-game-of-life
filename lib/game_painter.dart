import 'dart:math';

import 'package:flutter/material.dart';

class GamePainter extends CustomPainter {
  final Listenable ticker;

  GamePainter(this.ticker)
      : super(
          repaint: ticker,
        );

  @override
  void paint(Canvas canvas, Size size) {
    // Paints
    final linesPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Painting the grid
    for (final x = 0.0; x <= size.width;) {
      final xPath = Path();

      xPath.moveTo(x, 0);
      xPath.lineTo(x, size.height);

      canvas.drawPath(xPath, linesPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
