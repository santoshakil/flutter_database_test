import 'package:flutter/material.dart';
import 'package:flutter_database_test/database/data/data.dart';
import 'package:flutter_database_test/database/hive/hive.dart';
import 'package:flutter_database_test/database/sqflite/sqflite.dart';
import 'package:flutter_database_test/providers/counter_hive.dart';
import 'package:flutter_database_test/providers/counter_sqflite.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? operations;

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<CounterHive>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Database Test'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (v) => operations = int.tryParse(v),
                  ),
                ),
                SizedBox(
                  child: Divider(color: Colors.blue, thickness: 5.0),
                  width: MediaQuery.of(context).size.width,
                ),
                Consumer<CounterHive>(
                  builder: (_, provider, __) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Hive'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Operations Complated: ' +
                            provider.operation.toString()),
                      ),
                      provider.timeTook != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Times took for this operation: ' +
                                  provider.timeTook.toString() +
                                  ' Milliseconds'),
                            )
                          : provider.count != 0
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'Timer: ' + provider.count.toString()),
                                )
                              : SizedBox.shrink(),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (operations != null) {
                      await HiveDB.write(context, operations!);
                    }
                  },
                  child: Text('Write to Hive'),
                ),
                ElevatedButton(
                  onPressed: () async => await HiveDB.read(context),
                  child: Text('Read from Hive'),
                ),
                ElevatedButton(
                  onPressed: () async => await HiveDB.delete(context),
                  child: Text('Delete Hive Data'),
                ),
                ElevatedButton(
                  onPressed: _provider.reset,
                  child: Text('Reset'),
                ),
                // ElevatedButton(
                //   onPressed: () async {
                //     var _dataBox = Hive.isBoxOpen('data')
                //         ? Hive.box<DataClass>('data')
                //         : await Hive.openBox<DataClass>('data');
                //     print(_dataBox.values.length);
                //   },
                //   child: Text('Print'),
                // ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  child: Divider(color: Colors.blue, thickness: 5.0),
                  width: MediaQuery.of(context).size.width,
                ),
                Consumer<CounterSqflite>(
                  builder: (_, provider, __) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('SqfLite3'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Operations Complated: ' +
                            provider.operation.toString()),
                      ),
                      provider.timeTook != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Times took for this operation: ' +
                                  provider.timeTook.toString() +
                                  ' Milliseconds'),
                            )
                          : provider.count != 0
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'Timer: ' + provider.count.toString()),
                                )
                              : SizedBox.shrink(),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (operations != null) {
                      await SqfLiteDB.write(context, operations!);
                    }
                  },
                  child: Text('Write to SqfLite'),
                ),
                ElevatedButton(
                  onPressed: () async => await SqfLiteDB.read(context),
                  child: Text('Read from SqfLite'),
                ),
                ElevatedButton(
                  onPressed: () async => await SqfLiteDB.delete(context),
                  child: Text('Delete SqfLite Data'),
                ),
                ElevatedButton(
                  onPressed: _provider.reset,
                  child: Text('Reset'),
                ),
                // ElevatedButton(
                //   onPressed: () async {
                //     var _dataBox = Hive.isBoxOpen('data')
                //         ? Hive.box<DataClass>('data')
                //         : await Hive.openBox<DataClass>('data');
                //     print(_dataBox.values.length);
                //   },
                //   child: Text('Print'),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
