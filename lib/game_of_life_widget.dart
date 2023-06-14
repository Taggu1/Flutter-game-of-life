import 'package:flutter/material.dart';
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
  late AnimationController _tickerController;

  @override
  void initState() {
    super.initState();

    _tickerController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    )..forward();

    _tickerController.addListener(() {
      if (_tickerController.isCompleted) {
        _tickerController.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: CustomPaint(
        painter: GamePainter(_tickerController),
      ),
    );
  }
}
