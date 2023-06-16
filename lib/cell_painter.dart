import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

class CellPainter extends CustomPainter {
  final bool alive;
  final double left;
  final double top;

  final Paint paintSetting = Paint()..strokeWidth = 1;

  CellPainter({
    this.alive = false,
    required this.left,
    required this.top,
  });

  @override
  void paint(Canvas canvas, Size size) {
    paintSetting.color = Colors.teal;

    //canvas.drawRect(Rect.fromLTWH(left, top, size.width, size.height), paintSetting);
    paintSetting.color = alive ? Colors.white : Colors.black;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, size.width, size.height),
        const Radius.circular(0),
      ),
      paintSetting,
    );
    //canv
  }

  @override
  bool shouldRepaint(covariant CellPainter oldDelegate) {
    return oldDelegate.alive != alive ||
        oldDelegate.left != left ||
        oldDelegate.top != top;
  }
}
