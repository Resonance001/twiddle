import 'package:flutter/material.dart';
import 'package:twiddle/views/board_view.dart';

class InstructionView extends StatelessWidget {
  const InstructionView({
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
                  // TODO: Instruction View
                  child: Padding(
                    padding: EdgeInsets.all(50.0),
                    child: BoardView(),
                  ),
                )
          ),
    );
  }
}