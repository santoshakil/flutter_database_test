import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'table.dart';

class SqfLiteHelper {
  static final _databaseName = "AGL.db";
  static final _databaseVersion = 1;

  SqfLiteHelper._privateConstructor();
  static final SqfLiteHelper instance = SqfLiteHelper._privateConstructor();
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory? documentsDirectory = await getExternalStorageDirectory();
    String path = join(documentsDirectory!.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(BalanceTable.createTableCommand);
  }

  Future<int> insert(
      {required String table, required Map<String, dynamic> row}) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  Future<int> update(
      {required String table,
      required String columnId,
      required Map<String, dynamic> row}) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!
        .update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(
      {required String table,
      required String columnId,
      required int id}) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(
      {required String table}) async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  Future<int?> queryRowCount({required String table}) async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  }
}
