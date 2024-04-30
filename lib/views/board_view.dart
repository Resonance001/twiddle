import 'package:flutter/material.dart';
import 'package:twiddle/controllers/board_controller.dart';
import 'package:twiddle/controllers/game_controller.dart';
import 'package:twiddle/models/game_model.dart';
import 'package:twiddle/constants.dart';
import 'package:provider/provider.dart';

class BoardView extends StatefulWidget {
  const BoardView({super.key});

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var position = Provider.of<PositionModel>(context, listen: false);
    var controller = Provider.of<BoardController>(context, listen: true);
    var gameController = Provider.of<GameController>(context, listen: true);
    var isRotating = !gameController.isEnabled;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(isRotating){
        controller.rotateNums(position);
        if (controller.isOver) {
          Future.delayed(
            rotateDuration,
            () => ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Congratulations'))),
          );
        }
      }
    });

    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          var shouldRotate =
              isRotating && position.quadrant.elements.contains(index);
          var turns = shouldRotate ? position.rotation.turns : 0.0;
          var duration = shouldRotate ? rotateDuration : Duration.zero;
          var alignment =
              shouldRotate ? position.quadrant.pivot(index) : Alignment.center;
        
          return AnimatedRotation(
            turns: turns,
            duration: duration,
            alignment: alignment,
            child: Card(
              elevation: 3,
              color: Theme.of(context).cardColor,
              child: Center(
                child: AnimatedRotation(
                  turns: -turns,
                  duration: duration,
                  alignment: Alignment.center,
                  child: Text(
                    '${controller.nums[index]}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: 9,
        clipBehavior: Clip.none,
      ),
    );
  }
}
