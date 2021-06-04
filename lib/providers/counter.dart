import 'dart:async';

import 'package:flutter/foundation.dart';

class Counter with ChangeNotifier {
  int _timerCount = 0;
  int _operationsCount = 0;
  int? _timeTook;

  int get count => this._timerCount;

  int get operation => this._operationsCount;

  int? get timeTook => this._timeTook;
  set timeTook(int? value) {
    this._timeTook = value;
    notifyListeners();
  }

  Timer? _timer;

  void startCounter() {
    _timer = Timer.periodic(
      Duration(milliseconds: 10),
      (timer) {
        _timerCount = timer.tick * 10;
        notifyListeners();
      },
    );
  }

  void stopCounter() {
    if (_timer != null) {
      _timer!.cancel();
      notifyListeners();
    }
  }

  void increaseOperation() {
    _operationsCount++;
    notifyListeners();
  }

  void reset() {
    _timerCount = 0;
    _operationsCount = 0;
    _timeTook = null;
    notifyListeners();
  }
}
