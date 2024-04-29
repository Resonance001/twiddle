import 'package:flutter/material.dart';
import 'package:twiddle/views/board_view.dart';
import 'package:twiddle/controllers/game_controller.dart';
import 'package:provider/provider.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<GameController>(context, listen: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.height = context.size!.height;
      controller.width = context.size!.width;
    });

    return GestureDetector(
      onTapDown: controller.isEnabled ? controller.onTapDown : null,
      onSecondaryTapDown:
          controller.isEnabled ? controller.onSecondaryTapDown : null,
      child: const BoardView(),
    );
  }
}
