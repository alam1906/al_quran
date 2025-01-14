import 'package:hive_flutter/hive_flutter.dart';

part 'ayat_model.g.dart';

@HiveType(typeId: 1)
class AyatModel {
  @HiveField(0)
  int nomorAyat;
  @HiveField(1)
  String teksArab;
  @HiveField(2)
  String teksIndonesia;
  @HiveField(3)
  Map<String, dynamic> audio;
  @HiveField(4)
  bool isSelected = false;

  AyatModel({
    required this.nomorAyat,
    required this.teksArab,
    required this.teksIndonesia,
    required this.audio,
    required this.isSelected,
  });

  factory AyatModel.fromJson(Map<String, dynamic> json) {
    return AyatModel(
      nomorAyat: json['nomorAyat'],
      teksArab: json['teksArab'],
      teksIndonesia: json['teksIndonesia'],
      audio: json['audio'],
      isSelected: false,
    );
  }

  Map<String, dynamic> toJson() => {
        "nomorAyat": nomorAyat,
        "teksArab": teksArab,
        "teksIndonesia": teksIndonesia,
        "audio": audio,
        "isSelected": false,
      };

  AyatModel copyWith(
      {required int? nomorAyat,
      required String? teksArab,
      required String? teksIndonesia,
      required Map<String, dynamic>? audio,
      bool? isSelected}) {
    return AyatModel(
        nomorAyat: nomorAyat ?? this.nomorAyat,
        teksArab: teksArab ?? this.teksArab,
        teksIndonesia: teksIndonesia ?? this.teksIndonesia,
        audio: audio ?? this.audio,
        isSelected: isSelected ?? this.isSelected);
  }
}
