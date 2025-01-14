// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayat_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AyatModelAdapter extends TypeAdapter<AyatModel> {
  @override
  final int typeId = 1;

  @override
  AyatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AyatModel(
      nomorAyat: fields[0] as int,
      teksArab: fields[1] as String,
      teksIndonesia: fields[2] as String,
      audio: (fields[3] as Map).cast<String, dynamic>(),
      isSelected: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AyatModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.nomorAyat)
      ..writeByte(1)
      ..write(obj.teksArab)
      ..writeByte(2)
      ..write(obj.teksIndonesia)
      ..writeByte(3)
      ..write(obj.audio)
      ..writeByte(4)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AyatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
