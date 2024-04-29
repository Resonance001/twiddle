import 'package:flutter/material.dart';
import 'package:twiddle/controllers/game_controller.dart';
import 'package:twiddle/models/game_model.dart';
import 'package:provider/provider.dart';

class BoardView extends StatefulWidget {
  const BoardView({super.key});

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  bool isRotating = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<GameController>(context, listen: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isRotating) {
        controller.rotateNums();
      }
      isRotating = !isRotating;
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
              isRotating && controller.quadrant.elements.contains(index);
          var turns = shouldRotate ? controller.rotation.turns : 0.0;
          var duration = shouldRotate ? controller.duration : Duration.zero;
          var alignment = shouldRotate
              ? controller.quadrant.pivot(index)
              : Alignment.center;

          return AnimatedRotation(
            turns: turns,
            duration: duration,
            alignment: alignment,
            child: Card(
              color: Colors.blue,
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
