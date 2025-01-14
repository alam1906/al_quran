import 'dart:convert';

import 'package:al_quran/models/detail_surat_model.dart';
import 'package:al_quran/models/surat_model.dart';
import 'package:flutter/services.dart';

class SuratController {
  Future<List<SuratModel>> getAllSuratLokal() async {
    final String response =
        await rootBundle.loadString('assets/json/listsurat.json');
    final data = await jsonDecode(response) as Map<String, dynamic>;
    List<SuratModel> allSurat = [];
    for (var e in data['data']) {
      allSurat.add(SuratModel.fromJson(e));
    }
    return allSurat;
  }

  Future<DetailSuratModel> getDetailSuratLokal(int nomor) async {
    final String response =
        await rootBundle.loadString('assets/json/allsurat/$nomor.json');
    final data = await jsonDecode(response) as Map<String, dynamic>;
    final result = data['data'] as Map<String, dynamic>;
    final akhir = DetailSuratModel.fromJson(result);
    return akhir;
  }
}
