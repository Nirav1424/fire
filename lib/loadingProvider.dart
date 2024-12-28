import 'package:flutter/foundation.dart';

class Loadingprovider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }
}
