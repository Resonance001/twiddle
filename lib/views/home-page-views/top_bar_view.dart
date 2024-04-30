import 'package:flutter/material.dart';

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
      child: const SizedBox.expand()
    );
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
    return SizedBox.expand(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox.shrink(),
          const TopBarButton(
            text: 'New Game',
          ),
          TopBarButton(
            text: 'How To Play',
            turns: 0.5,
            onTap: _onTap,
            isOpen: _isOpen,
          ),
          const TopBarButton(
            text: 'Reset Board',
          ),
          const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class TopBarButton extends StatelessWidget {
  const TopBarButton(
      {super.key,
      void Function()? onTap,
      required String text,
      double? turns,
      Duration? duration,
      bool? isOpen})
      : _onTap = onTap,
        _text = text,
        _turns = turns ?? 1.0,
        _duration = duration ?? const Duration(milliseconds: 250),
        _isOpen = isOpen ?? true;

  final void Function()? _onTap;
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
        onTap: _onTap ?? () => {},
        hoverColor: Theme.of(context).hoverColor,
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _text,
                style:  const TextStyle(color: Colors.white),
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