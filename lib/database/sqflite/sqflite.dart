import 'package:flutter/material.dart';
import 'package:flutter_database_test/database/sqflite/database.dart';
import 'package:flutter_database_test/database/sqflite/table.dart';
import 'package:flutter_database_test/providers/counter_sqflite.dart';
import 'package:provider/provider.dart';

import '../../providers/counter_hive.dart';

class SqfLiteDB {
  static Future<void> write(BuildContext context, int n) async {
    try {
      var _counter = Provider.of<CounterSqflite>(context, listen: false);
      _counter.startCounter();
      var startTime = DateTime.now().millisecondsSinceEpoch;

      var db = SqfLiteHelper.instance;
      for (int i = 0; i < n; i++) {
        await db.insert(
            table: BalanceTable.tableName, row: {BalanceTable.name: 'Name $i'});
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
      var _counter = Provider.of<CounterSqflite>(context, listen: false);
      _counter.startCounter();
      var startTime = DateTime.now().millisecondsSinceEpoch;

      var db = SqfLiteHelper.instance;
      var _datas = await db.queryAllRows(table: BalanceTable.tableName);
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
      var _counter = Provider.of<CounterSqflite>(context, listen: false);
      _counter.startCounter();
      var startTime = DateTime.now().millisecondsSinceEpoch;

      var db = SqfLiteHelper.instance;
      int? total = await db.queryRowCount(table: BalanceTable.tableName);
      for (int i = 0; i < total!; i++) {
        await db.delete(
          table: BalanceTable.tableName,
          columnId: BalanceTable.id,
          id: i,
        );
      }

      _counter.stopCounter();
      var endTime = DateTime.now().millisecondsSinceEpoch;
      _counter.timeTook = endTime - startTime;

      print('Times took for this operation: ' + _counter.timeTook.toString());
    } catch (e) {
      print('Error: ' + e.toString());
    }
  }
}
