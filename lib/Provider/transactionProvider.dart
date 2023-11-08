import 'package:flutter/foundation.dart';

class TransactionProvider with ChangeNotifier {
  String _selectedmonth = "AllMonths";
  String get selectedmonth => _selectedmonth;
  void setSelectedMonth(String month) {
    _selectedmonth = month;
    notifyListeners();
  }
}
