import 'package:al_quran/models/ayat_model.dart';

class DetailSuratModel {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final Map<String, dynamic> audioFull;
  final List<AyatModel> ayat;

  DetailSuratModel({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.audioFull,
    required this.ayat,
  });

  factory DetailSuratModel.fromJson(Map<String, dynamic> json) {
    return DetailSuratModel(
      nomor: json['nomor'],
      nama: json['nama'],
      namaLatin: json['namaLatin'],
      jumlahAyat: json['jumlahAyat'],
      tempatTurun: json['tempatTurun'],
      arti: json['arti'],
      audioFull: json['audioFull'],
      ayat:
          List<AyatModel>.from(json['ayat'].map((x) => AyatModel.fromJson(x))),

      // suratSelanjutnya: json['suratSelanjutnya'],
      // suratSebelumnya: json['suratSebelumnya'],
    );
  }
}
