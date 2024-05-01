import 'package:flutter/material.dart';
import 'package:twiddle/controllers/board_controller.dart';
import 'package:twiddle/controllers/game_controller.dart';
import 'package:twiddle/controllers/instruction_controller.dart';
import 'package:twiddle/models/game_model.dart';
import 'package:twiddle/constants.dart';
import 'package:provider/provider.dart';

class BoardViewParent extends StatelessWidget {
  const BoardViewParent({this.isInstruction = false, super.key});

  final bool isInstruction;
  @override
  Widget build(BuildContext context) {
    return isInstruction
        ? Consumer<InstructionController>(
            builder: (context, instructionController, child) {
              return BoardView(
                rotateNums: instructionController.rotateNums,
                isRotating: instructionController.isInstructing,
                nums: instructionController.nums,
              );
            },
          )
        : Consumer2<GameController, BoardController>(
            builder: (context, gameController, boardController, child) {
              return BoardView(
                rotateNums: boardController.rotateNums,
                isRotating: !gameController.isEnabled,
                isOver: boardController.isOver,
                nums: boardController.nums,
              );
            },
          );
  }
}

class BoardView extends StatefulWidget {
  const BoardView({
    required this.rotateNums,
    this.isRotating = false,
    this.isOver = false,
    this.nums = const [],
    super.key,
  });

  final void Function(PositionModel) rotateNums;
  final bool isRotating;
  final bool isOver;
  final List<int> nums;

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  @override
  void initState() {
    super.initState();
    // TODO: load shuffled nums when new game is pessed
  }

  @override
  Widget build(BuildContext context) {
    var position = Provider.of<PositionModel>(context, listen: false);

    var rotateNums = widget.rotateNums;
    var isRotating = widget.isRotating;
    var isOver = widget.isOver;
    var nums = widget.nums;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isRotating) {
        rotateNums(position);
        if(isOver){ // not working.. need to tap one more time to trigger
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
          var shouldRotate = isRotating && position.quadrant.elements.contains(index);
          var turns = shouldRotate ? position.rotation.turns : 0.0;
          var duration = shouldRotate ? rotateDuration : Duration.zero;
          var alignment =
              shouldRotate ? position.quadrant.pivot(index) : Alignment.center;

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
                    '${nums[index]}',
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
