import 'package:flutter/material.dart';
import 'package:twiddle/models/game_model.dart';
import 'package:twiddle/views/board_view.dart';
import 'package:twiddle/controllers/game_controller.dart';
import 'package:provider/provider.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  
  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PositionModel>().height = context.size!.height;
      context.read<PositionModel>().width = context.size!.width;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var position = Provider.of<PositionModel>(context, listen: false);
    var controller = Provider.of<GameController>(context, listen: true);

    return GestureDetector(
      onTapDown: (details) => 
          controller.isEnabled ? controller.onTapDown(position, details) : null,
      onSecondaryTapDown: (details) =>
          controller.isEnabled ? controller.onSecondaryTapDown(position, details) : null,
      child: const BoardViewParent(),
    );
  }
}
