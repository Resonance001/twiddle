import 'package:flutter/material.dart';
import 'package:twiddle/views/board_view.dart';
import 'package:twiddle/views/home-page-views/instruction-view/animated_instruction.dart';
import 'package:twiddle/views/home-page-views/instruction-view/animated_text.dart';

class InstructionWindow extends StatelessWidget {
  const InstructionWindow({
    super.key,
    required Duration duration,
    required bool isOpen,
  })  : _duration = duration,
        _isOpen = isOpen;

  final Duration _duration;
  final bool _isOpen;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColorDark,
      borderRadius: BorderRadius.circular(30),
      child: AnimatedSize(
        duration: _duration,
        alignment: Alignment.topCenter,
        curve: Curves.ease,
        child: !_isOpen
            ? const SizedBox.shrink()
            : const SizedBox(
                width: 500,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: InstructionView(),
                ),
              ),
      ),
    );
  }
}

class InstructionView extends StatelessWidget {
  const InstructionView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              BoardViewParent(isInstruction: true),
              AnimatedInstruction(),
            ],
          ),
        ),
        SizedBox(
          height: 50.0,
          child: FittedBox(
            fit: BoxFit.contain,
            child: AnimatedText(),
          ),
        )
      ],
    );
  }
}
