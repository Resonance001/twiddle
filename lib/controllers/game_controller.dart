import 'package:flutter/material.dart';
import 'package:twiddle/models/game_model.dart';

class GameController extends ChangeNotifier {
  Rotation rotation = Rotation.values.first;
  Quadrant quadrant = Quadrant.values.first;

  double height = 0.0;
  double width = 0.0;

  final duration = const Duration(milliseconds: 500);
  var nums = <int>[2, 3, 6, 1, 5, 4, 7, 8, 9];

  bool _isEnabled = true;

  bool get isEnabled => _isEnabled;

  toggleEnabled() {
    _isEnabled = !_isEnabled;
    notifyListeners();
  }

  void onTapDown(TapDownDetails details) {
    rotation = Rotation.counterclockwise;
    quadrant = calcQuadrant(details);
    toggleEnabled();

    Future.delayed(duration, () => toggleEnabled());
  }

  void onSecondaryTapDown(TapDownDetails details) {
    rotation = Rotation.clockwise;
    quadrant = calcQuadrant(details);
    toggleEnabled();

    Future.delayed(duration, () => toggleEnabled());
  }

  Quadrant calcQuadrant(TapDownDetails details) {
    return details.localPosition.dy < height / 2
        ? (details.localPosition.dx < width / 2 ? Quadrant.I : Quadrant.II)
        : (details.localPosition.dx < width / 2 ? Quadrant.III : Quadrant.IX);
  }

  void rotateNums()
    => nums = switch([rotation, quadrant]){
        [Rotation.clockwise, Quadrant.I] => [
          nums[3],nums[0],nums[2],
          nums[4],nums[1],nums[5],
          nums[6],nums[7],nums[8]],
        [Rotation.counterclockwise, Quadrant.I] => [
          nums[1],nums[4],nums[2],
          nums[0],nums[3],nums[5],
          nums[6],nums[7],nums[8]],
        [Rotation.clockwise, Quadrant.II] => [
          nums[0],nums[4],nums[1],
          nums[3],nums[5],nums[2],
          nums[6],nums[7],nums[8]],
        [Rotation.counterclockwise, Quadrant.II] => [
          nums[0],nums[2],nums[5],
          nums[3],nums[1],nums[4],
          nums[6],nums[7],nums[8]],
        [Rotation.clockwise, Quadrant.III] => [
          nums[0],nums[1],nums[2],
          nums[6],nums[3],nums[5],
          nums[7],nums[4],nums[8]],
        [Rotation.counterclockwise, Quadrant.III] => [
          nums[0],nums[1],nums[2],
          nums[4],nums[7],nums[5],
          nums[3],nums[6],nums[8]],
        [Rotation.clockwise, Quadrant.IX] => [
          nums[0],nums[1],nums[2],
          nums[3],nums[7],nums[4],
          nums[6],nums[8],nums[5]], 
        [Rotation.counterclockwise, Quadrant.IX] => [
          nums[0],nums[1],nums[2],
          nums[3],nums[5],nums[8],
          nums[6],nums[4],nums[7]], 
        _ => [],
  };
}
