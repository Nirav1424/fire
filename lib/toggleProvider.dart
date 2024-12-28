

import 'package:flutter/foundation.dart';

class Toggleprovider with ChangeNotifier {
  bool _hidinData = false;
  bool get hidindata => _hidinData;

  void setBool(bool val) {
    _hidinData = !val;
    notifyListeners();
  }
}
