import 'package:flutter/material.dart';
import 'package:twiddle/controllers/game_controller.dart';
import 'package:twiddle/models/game_model.dart';

class BoardView extends StatefulWidget {
  const BoardView({required this.controller, super.key});

  final GameController controller;

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  late final GameController _controller;
  bool isRotating = false;

  @override
  void initState(){
    super.initState();
    _controller = widget.controller;
    _controller.addListener(() async {
      if(_controller.isOver){
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Congratulations')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isRotating) {
        widget.controller.rotateNums();
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
          var shouldRotate = isRotating && _controller.quadrant.elements.contains(index);
          var turns = shouldRotate ? _controller.rotation.turns : 0.0;
          var duration = shouldRotate ? _controller.duration : Duration.zero;
          var alignment = shouldRotate ? _controller.quadrant.pivot(index) : Alignment.center;

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
                    child: Text('${_controller.nums[index]}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                )),
          );
        },
        itemCount: 9,
        clipBehavior: Clip.none,
      ),
    );
  }
}
