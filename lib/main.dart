import 'package:flutter/material.dart';
import 'package:flutter_database_test/providers/counter_sqflite.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'database/data/data.dart';
import 'providers/counter_hive.dart';
import 'screens/home/home.dart';

Future<void> main() async {
  Hive.registerAdapter(DataClassAdapter());
  await Hive.initFlutter();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CounterHive>(create: (_) => CounterHive()),
        ChangeNotifierProvider<CounterSqflite>(create: (_) => CounterSqflite()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    ),
  );
}
