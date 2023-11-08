import 'package:flutter/foundation.dart';

class ExpenseProvider with ChangeNotifier {

  double _netCredited = 0.0;
  double _netDebited = 0.0;

  double get netDebited => _netDebited;
  double get netCredited => _netCredited;

  void setExpense(double cred, double deb) {
    _netCredited = cred;
    _netDebited = deb;
    notifyListeners();
  }
}
