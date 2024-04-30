import 'package:flutter/foundation.dart';

class TopBarController extends ChangeNotifier {
  bool isOpen = false;

  Duration duration = const Duration(milliseconds: 500);

  void toggleOpen(){
    isOpen = !isOpen;
    notifyListeners();
  }

  bool isNewGame = false;
}