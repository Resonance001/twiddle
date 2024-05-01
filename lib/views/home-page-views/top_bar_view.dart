import 'package:flutter/material.dart';
import 'package:twiddle/controllers/instruction_controller.dart';
import 'package:twiddle/controllers/board_controller.dart';
import 'package:provider/provider.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).primaryColorLight,
        elevation: 10,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
        child: const SizedBox.expand());
  }
}

class TopBarButtonList extends StatelessWidget {
  const TopBarButtonList({
    super.key,
    required void Function() onTap,
    required bool isOpen,
  })  : _onTap = onTap,
        _isOpen = isOpen;

  final void Function() _onTap;
  final bool _isOpen;

  @override
  Widget build(BuildContext context) {
    var boardController = context.read<BoardController>();
    var instructionController = context.read<InstructionController>();
    return SizedBox.expand(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox.shrink(),
          TopBarButton(
            text: 'New Game',
            onTap: [
              boardController.newNums,
            ],
          ),
          TopBarButton(
            text: 'How To Play',
            turns: 0.5,
            onTap: [
              _onTap,
              if (!_isOpen) instructionController.start,
              if (_isOpen) instructionController.resetNums,
            ],
            isOpen: _isOpen,
          ),
          TopBarButton(
            text: 'Reset Board',
            onTap: [
              boardController.resetNums,
            ],
          ),
          const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class TopBarButton extends StatelessWidget {
  const TopBarButton({
    super.key,
    required List<void Function()> onTap,
    required String text,
    double? turns,
    Duration? duration,
    bool? isOpen,
  })  : _onTap = onTap,
        _text = text,
        _turns = turns ?? 1.0,
        _duration = duration ?? const Duration(milliseconds: 250),
        _isOpen = isOpen ?? true;

  final List<void Function()> _onTap;
  final String _text;
  final double _turns;
  final Duration _duration;
  final bool _isOpen;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColorDark,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        // ignore: avoid_function_literals_in_foreach_calls
        onTap: () => _onTap.forEach((tap) => tap()),
        hoverColor: Theme.of(context).hoverColor,
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _text,
                style: const TextStyle(color: Colors.white),
              ),
              AnimatedRotation(
                turns: _isOpen ? _turns : 0.0,
                duration: _duration,
                curve: Curves.easeOut,
                child: const Icon(Icons.help_outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
