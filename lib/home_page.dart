import 'package:flutter/material.dart';
import 'package:twiddle/views/board_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(100.0),
          child: BoardView(),
        )
      )
    );
  }
}