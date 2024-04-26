enum Rotation { 
  clockwise, 
  counterclockwise 
}

extension RotationExtension on Rotation {
  double get rotationAngle => switch (this) {
    Rotation.clockwise => 1.0 / 4.0,
    Rotation.counterclockwise => -1.0 / 4.0
  };
}