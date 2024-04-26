import 'package:flutter/material.dart';
import 'package:twiddle/models/game_model.dart';

class GameController extends ChangeNotifier {
  Rotation rotation = Rotation.values.first;

  final duration = const Duration(milliseconds : 500);
  var nums = <int>[2, 3, 6, 1, 5, 4, 7, 8, 9];

  bool _isEnabled = true;

  bool get isEnabled => _isEnabled;

  toggleEnabled() {
    _isEnabled = !_isEnabled;
    notifyListeners();
  }

  void onTapDown(TapDownDetails details) {
    rotation = Rotation.counterclockwise;
    toggleEnabled();

    Future.delayed(duration, () => toggleEnabled());
  }

  void onSecondaryTapDown(TapDownDetails details) {
    rotation = Rotation.clockwise;
    toggleEnabled();

    Future.delayed(duration, () => toggleEnabled());
  }
}