import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText({super.key});

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  final _style = const TextStyle(color: Colors.white, fontSize: 30);
  final _duration = const Duration(seconds: 4);
  final _instructions = [
    'Left click on the center of a 2x2 tile to rotate counterclockwise',
    'Right click on the center of a 2x2 tile to rotate clockwise',
    'Arrange the board into a numerical order from top left to bottom right',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: _style,
      maxLines: 2,
      child: AnimatedTextKit(
        pause: const Duration(milliseconds: 100),
        isRepeatingAnimation: true,
        animatedTexts: [
          for (var instruction in _instructions)
            RotateAnimatedText(
              instruction,
              duration: _duration,
            ),
        ],
      ),
    );
  }
}
