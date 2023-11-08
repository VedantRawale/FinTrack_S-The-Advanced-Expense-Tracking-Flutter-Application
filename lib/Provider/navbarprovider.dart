import 'package:flutter/foundation.dart';

class NavBarProvider with ChangeNotifier {
  bool _hidenavbar = false;
  bool get hidenavbar => _hidenavbar;
  void setNavStatus(bool status) {
    _hidenavbar = status;
    notifyListeners();
  }
}
