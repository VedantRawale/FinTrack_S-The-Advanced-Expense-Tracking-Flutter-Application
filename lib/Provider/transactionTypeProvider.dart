import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class TransacTypeProvider with ChangeNotifier {
  bool _debited = true;
  bool get debited => _debited;
  void changeTransactionType(bool deb) {
    _debited = deb;
    notifyListeners();
  }
}
