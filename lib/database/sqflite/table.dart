class BalanceTable {
  static const String tableName = 'my_table', id = 'id', name = 'name';

  static String createTableCommand = '''
          CREATE TABLE $tableName (
            $id INTEGER PRIMARY KEY,
            $name TEXT
          )
          ''';
}
