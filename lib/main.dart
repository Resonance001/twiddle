import 'package:flutter/material.dart';
import 'package:twiddle/views/home_page.dart';
import 'package:provider/provider.dart';
import 'package:twiddle/controllers/game_controller.dart';
import 'package:twiddle/controllers/board_controller.dart';
import 'package:twiddle/controllers/top_bar_controller.dart';
import 'package:twiddle/controllers/instruction_controller.dart';
import 'package:twiddle/models/game_model.dart';
import 'dart:html';

void main() {
  window.document.onContextMenu.listen((evt) => evt.preventDefault());
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => PositionModel()),
        ChangeNotifierProvider(create: (context) => GameController()),
        ChangeNotifierProvider(create: (context) => BoardController()),
        ChangeNotifierProvider(create: (context) => TopBarController()),
        ChangeNotifierProvider(create: (context) => InstructionController()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light,
      // home: const HomePage(),
      home: const HomePage()
    );
  }
}
