import 'package:flutter/material.dart';
import 'package:twiddle/models/game_model.dart';
import 'package:twiddle/constants.dart';

class InstructionController extends ChangeNotifier {
  bool isStart = false;
  static const defaultNums = <int>[4, 1, 3, 6, 2, 9, 7, 5, 8];
  var nums = <int>[4, 1, 3, 6, 2, 9, 7, 5, 8];

  void resetNums(){
    nums = defaultNums;
  }

  bool isInstructing = false;

  toggleInstructing() {
    isInstructing = !isInstructing;
    notifyListeners();

    Future.delayed(rotateDuration, () {
      isInstructing = !isInstructing;
    });
  }

  bool _isVisible = false;

  double get opacity => _isVisible ? 1.0 : 0.0;

  Duration get duration => _isVisible
      ? const Duration(seconds: 1)
      : const Duration(milliseconds: 500);

  void fadeIn(){
    _isVisible = true;
  }

  void fadeOut(){
    _isVisible = false;
  }

  void start(){
    isStart = true;    
    notifyListeners();
  }

  void onLeftClick(PositionModel position){
    position.rotation = Rotation.counterclockwise;
    position.quadrant = Quadrant.I;
    toggleInstructing();
  }
  void onRightClick(PositionModel position){
    position.rotation = Rotation.clockwise;
    position.quadrant = Quadrant.IX;
    toggleInstructing();
  }

  void rotateNums(PositionModel position)
    => nums = switch([position.rotation, position.quadrant]){
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
