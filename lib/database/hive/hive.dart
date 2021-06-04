import 'package:flutter/material.dart';
import 'package:flutter_database_test/database/data/data.dart';
import 'package:flutter_database_test/providers/counter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class HiveDB {
  static Future<void> write(BuildContext context, int n) async {
    try {
      var _counter = Provider.of<Counter>(context, listen: false);
      _counter.startCounter();
      var startTime = DateTime.now().millisecondsSinceEpoch;

      var _dataBox = Hive.isBoxOpen('data')
          ? Hive.box<DataClass>('data')
          : await Hive.openBox<DataClass>('data');

      for (int i = 0; i < n; i++) {
        await _dataBox.add(DataClass(uniqueID: i, name: 'Name $i'));
        _counter.increaseOperation();
      }
      // await Future.delayed(Duration(seconds: 5));

      _counter.stopCounter();
      var endTime = DateTime.now().millisecondsSinceEpoch;
      _counter.timeTook = endTime - startTime;

      print('Times took for this operation: ' + _counter.timeTook.toString());
    } catch (e) {
      print('Error: ' + e.toString());
    }
  }

  static Future<void> read(BuildContext context) async {
    try {
      var _counter = Provider.of<Counter>(context, listen: false);
      _counter.startCounter();
      var startTime = DateTime.now().millisecondsSinceEpoch;

      var _dataBox = Hive.isBoxOpen('data')
          ? Hive.box<DataClass>('data')
          : await Hive.openBox<DataClass>('data');

      var _datas = _dataBox.values.toList();
      print('Data Length: ' + _datas.length.toString());

      _counter.stopCounter();
      var endTime = DateTime.now().millisecondsSinceEpoch;
      _counter.timeTook = endTime - startTime;

      print('Times took for this operation: ' + _counter.timeTook.toString());
    } catch (e) {
      print('Error: ' + e.toString());
    }
  }

  static Future<void> delete(BuildContext context) async {
    try {
      var _counter = Provider.of<Counter>(context, listen: false);
      _counter.startCounter();
      var startTime = DateTime.now().millisecondsSinceEpoch;

      var _dataBox = Hive.isBoxOpen('data')
          ? Hive.box<DataClass>('data')
          : await Hive.openBox<DataClass>('data');

      await _dataBox.deleteFromDisk();

      _counter.stopCounter();
      var endTime = DateTime.now().millisecondsSinceEpoch;
      _counter.timeTook = endTime - startTime;

      print('Times took for this operation: ' + _counter.timeTook.toString());
    } catch (e) {
      print('Error: ' + e.toString());
    }
  }
}
