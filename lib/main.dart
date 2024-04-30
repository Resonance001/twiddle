import 'package:flutter/material.dart';
import 'package:twiddle/views/home_page.dart';
import 'package:provider/provider.dart';
import 'controllers/game_controller.dart';
import 'controllers/board_controller.dart';
import 'controllers/top_bar_controller.dart';
import 'models/game_model.dart';
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
      home: const HomePage()
    );
  }
}
