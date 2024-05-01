import 'package:twiddle/models/game_model.dart';
import 'package:flutter/foundation.dart';

class BoardController extends ChangeNotifier {
  var initialNums = <int>[2, 3, 6, 1, 5, 4, 7, 8, 9];
  var nums = <int>[2, 3, 6, 1, 5, 4, 7, 8, 9];

  var finalNums = const <int>[1, 2, 3, 4, 5, 6, 7, 8, 9];

  void newNums(){
    var temp = [...finalNums];
    temp.shuffle();
    initialNums = temp;
    resetNums();
  }

  void resetNums(){
    nums = initialNums;
    notifyListeners();
  }

  bool get isOver{
    return listEquals(nums, finalNums);
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
