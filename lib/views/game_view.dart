import 'package:flutter/material.dart';
import 'package:twiddle/models/game_model.dart';
import 'package:twiddle/views/board_view.dart';
import 'package:twiddle/controllers/game_controller.dart';
import 'package:provider/provider.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    var position = Provider.of<PositionModel>(context, listen: false);
    var controller = Provider.of<GameController>(context, listen: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      position.height = context.size!.height;
      position.width = context.size!.width;
    });

    return GestureDetector(
      onTapDown: (details) => 
          controller.isEnabled ? controller.onTapDown(position, details) : null,
      onSecondaryTapDown: (details) =>
          controller.isEnabled ? controller.onSecondaryTapDown(position, details) : null,
      child: const BoardView(),
    );
  }
}
