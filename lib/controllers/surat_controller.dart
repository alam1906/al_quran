import 'dart:convert';

import 'package:al_quran/models/detail_surat_model.dart';
import 'package:al_quran/models/surat_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class SuratController {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://equran.id/api/v2',
    ),
  );
  Future<List<SuratModel>> getAllSurat() async {
    final response = await dio.get('/surat');
    final data = response.data as Map<String, dynamic>;

    List<SuratModel> allSurat = [];
    for (var e in data['data']) {
      allSurat.add(SuratModel.fromJson(e));
    }

    return allSurat;
  }

  Future<DetailSuratModel> getDetailSurat(int nomor) async {
    final response = await dio.get('/surat/$nomor');
    final data = response.data as Map<String, dynamic>;
    final result = data['data'] as Map<String, dynamic>;
    final akhir = DetailSuratModel.fromJson(result);
    return akhir;
  }

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
