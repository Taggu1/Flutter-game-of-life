import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_game_of_life/game_painter.dart';

class GameOfLifeWidget extends StatefulWidget {
  final double width;
  final double height;
  const GameOfLifeWidget(
      {super.key, required this.width, required this.height});

  @override
  State<GameOfLifeWidget> createState() => _GameOfLifeWidgetState();
}

class _GameOfLifeWidgetState extends State<GameOfLifeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: widget.height,
      width: widget.width,
      child: CustomPaint(
        painter: GamePainter(_controller),
      ),
    );
  }
}
