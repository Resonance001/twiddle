import 'package:flutter/material.dart';

enum Rotation { clockwise, counterclockwise }

extension RotationExtension on Rotation {
  double get turns => switch (this) {
        Rotation.clockwise => 1.0 / 4.0,
        Rotation.counterclockwise => -1.0 / 4.0
      };
}

enum Quadrant {
  I,
  II,
  III,
  IX,
}

extension QuadrantExtension on Quadrant {
  List<int> get elements => switch (this) {
        Quadrant.I => [0, 1, 3, 4],
        Quadrant.II => [1, 2, 4, 5],
        Quadrant.III => [3, 4, 6, 7],
        Quadrant.IX => [4, 5, 7, 8]
      };

  Alignment pivot(int index) => [
        Alignment.bottomRight,
        Alignment.bottomLeft,
        Alignment.topRight,
        Alignment.topLeft,
      ].elementAt(elements.indexWhere((i) => i == index));
}
