import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twiddle/controllers/instruction_controller.dart';
import 'package:twiddle/models/game_model.dart';

class AnimatedInstruction extends StatefulWidget {
  const AnimatedInstruction({super.key});

  @override
  State<AnimatedInstruction> createState() => _AnimatedInstructionState();
}

class _AnimatedInstructionState extends State<AnimatedInstruction>
    with TickerProviderStateMixin {
  late InstructionController playController;
  late PositionModel position;

  late AnimationController controller;
  late Animation<double> animation;
  late Tween<double> _tween;

  var cursorSize = 0.0;
  var tweenLength = 0.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _tween = Tween(begin: 0.0, end: 0.0);
    animation = _tween.animate(controller)..addListener(() => setState(() {}));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cursorSize = context.size!.height / 8;
      tweenLength = (2 / 3) * context.size!.height - cursorSize / 2;
    });
  }

  @override
  void didChangeDependencies() {
    playController = context.watch<InstructionController>();
    position = context.read<PositionModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (playController.isStart) {
        playController.isStart = false;
        start();
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void start() {
    _tween.end = tweenLength;

    playController.fadeIn();
    if (mounted) {
      controller.forward().whenComplete(() {
        playController.onLeftClick(position);

        _tween.begin = _tween.end;
        _tween.end = tweenLength / 2 - cursorSize / 4;
        controller.reset();

        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            controller.forward().whenComplete(() {
              playController.onRightClick(position);
              playController.fadeOut();

              Future.delayed(const Duration(seconds: 6), () {
                _tween.begin = 0;

                if (mounted) {
                  controller.reset();
                  playController.start();
                }
              });
            });
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: AnimatedOpacity(
        opacity: playController.opacity,
        duration: playController.duration,
        child: Transform.translate(
          offset: Offset(-animation.value, -animation.value),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              Icons.touch_app,
              size: cursorSize,
            ),
          ),
        ),
      ),
    );
  }
}
