
import 'package:flutter/material.dart';
import 'package:twiddle/models/game_model.dart';
import 'package:twiddle/constants.dart';

class GameController extends ChangeNotifier {
  bool _isEnabled = true;

  bool get isEnabled => _isEnabled;

    toggleEnabled() {
    _isEnabled = !_isEnabled;
    notifyListeners();

    Future.delayed(rotateDuration, () {
      _isEnabled = !_isEnabled;
      notifyListeners();
    });
  }

   void onTapDown(PositionModel position, TapDownDetails details) {
    position.rotation = Rotation.counterclockwise;
    position.quadrant = calcQuadrant(position, details);
    toggleEnabled();
  }

  void onSecondaryTapDown(PositionModel position, TapDownDetails details) {
    position.rotation = Rotation.clockwise;
    position.quadrant = calcQuadrant(position, details);
    toggleEnabled();

  }

  Quadrant calcQuadrant(PositionModel position, TapDownDetails details) {
    return details.localPosition.dy < position.height / 2
        ? (details.localPosition.dx < position.width / 2 ? Quadrant.I : Quadrant.II)
        : (details.localPosition.dx < position.width / 2 ? Quadrant.III : Quadrant.IX);
  }
}
