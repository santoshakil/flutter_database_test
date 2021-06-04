import 'package:hive/hive.dart';

part 'data.g.dart';

@HiveType(typeId: 0)
class DataClass extends HiveObject {
  @HiveField(0)
  int? uniqueID;
  @HiveField(1)
  String? name;

  DataClass({this.uniqueID, this.name});
}
