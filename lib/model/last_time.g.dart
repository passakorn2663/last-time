// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_time.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LastTimeAdapter extends TypeAdapter<LastTime> {
  @override
  final int typeId = 0;

  @override
  LastTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LastTime(
      title: fields[0] as String,
      category: fields[1] as String,
      lastTime: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LastTime obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LastTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
