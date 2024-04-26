import 'package:flutter/material.dart';
import 'package:twiddle/views/board_view.dart';
import 'package:twiddle/controllers/game_controller.dart';

class GameView extends StatelessWidget {
    GameView({super.key});

    final GameController _controller = GameController();

    @override
    Widget build(BuildContext context) {
      return ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _controller.height = context.size!.height;
            _controller.width = context.size!.width;
          });

          return GestureDetector(
            onTapDown: _controller.isEnabled ? _controller.onTapDown : null,
            onSecondaryTapDown: _controller.isEnabled ? _controller.onSecondaryTapDown : null,
            child: BoardView(controller: _controller)
          );
        }
      );
    }
  }
  