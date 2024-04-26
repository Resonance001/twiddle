import 'package:flutter/material.dart';
import 'package:twiddle/views/game_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(100.0),
          child: GameView(),
        )
      )
    );
  }
}