import 'package:flutter/foundation.dart';

class Favouriteprovider with ChangeNotifier {
  List<int> _selected = [];
  List<int> get selected => _selected;

  void addItem(int index) {
    selected.add(index);
    notifyListeners();
  }

  void removeItem(int index) {
    selected.remove(index);
    notifyListeners();
  }
}
