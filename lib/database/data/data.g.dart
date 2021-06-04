// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataClassAdapter extends TypeAdapter<DataClass> {
  @override
  final int typeId = 0;

  @override
  DataClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataClass(
      uniqueID: fields[0] as int?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DataClass obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.uniqueID)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
