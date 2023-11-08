import 'package:flutter/foundation.dart';

class DateAtAddTransactionProvider with ChangeNotifier {
  DateTime _dateTime = DateTime.now();
  DateTime get dateTime => _dateTime;
  void setDate(DateTime val) {
    _dateTime = val;
    notifyListeners();
  }
}
