import 'package:flutter/material.dart';
import 'package:twiddle/views/game_view.dart';
import 'package:provider/provider.dart';
import '../controllers/top_bar_controller.dart';
import 'package:twiddle/views/home-page-views/instruction_view.dart';
import 'package:twiddle/views/home-page-views/top_bar_view.dart';
import 'package:twiddle/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<TopBarController>(
        builder: (context, controller, child) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              BackgroundOpacity(
                duration: controller.duration,
                isOpen: controller.isOpen,
                toggleOpen: controller.toggleOpen,
              ),
              const Positioned(
                top: 0.0,
                height: Offset.topBarHeight,
                left: 0.0,
                right: 0.0,
                child: TopBar(),
              ),
              const Positioned(
                top: Offset.topGameOffset,
                bottom: Offset.bottomGameOffset,
                child: GameView(),
              ),
              Positioned(
                top: Offset.topBarOffset,
                height: Offset.topBarHeight,
                left: 0.0,
                right: 0.0,
                child: TopBarButtonList(
                  onTap: controller.toggleOpen,
                  isOpen: controller.isOpen,
                ),
              ),
              Positioned(
                top: Offset.topBarHeight,
                bottom: Offset.topBarHeight,
                child: InstructionView(
                  duration: controller.duration,
                  isOpen: controller.isOpen,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class BackgroundOpacity extends StatelessWidget {
  const BackgroundOpacity(
      {super.key,
      required Duration duration,
      required bool isOpen,
      required void Function() toggleOpen})
      : _duration = duration,
        _isOpen = isOpen,
        _toggleOpen = toggleOpen;

  final Duration _duration;
  final bool _isOpen;
  final void Function() _toggleOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _isOpen ? _toggleOpen : null,
        child: AnimatedOpacity(
            duration: _duration,
            opacity: _isOpen ? 1.0 : 0.0,
            child: Container(color: Colors.black38)));
  }
}
