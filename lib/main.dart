import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'database/data/data.dart';
import 'providers/counter.dart';
import 'screens/home/home.dart';

Future<void> main() async {
  Hive.registerAdapter(DataClassAdapter());
  await Hive.initFlutter();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Counter>(create: (_) => Counter()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    ),
  );
}
