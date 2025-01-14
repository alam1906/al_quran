import 'package:al_quran/box_ayat_model.dart';
import 'package:al_quran/models/ayat_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_provider.g.dart';

@Riverpod(keepAlive: true)
class Bookmark extends _$Bookmark {
  @override
  Future<List<AyatModel>?> build() async {
    int data = boxAyatModel.length;
    if (data > 0) {
      List<AyatModel>? ayatModel = [];
      for (var i = 0; i < data; i++) {
        final result = await boxAyatModel.getAt(i);
        ayatModel.add(result);
      }

      return ayatModel;
    } else {
      return null;
    }
  }

  AyatModel? getByKey({required String key}) {
    final data = boxAyatModel.get(key);
    return data;
  }

  refreshData() async {
    int data = boxAyatModel.length;
    List<AyatModel> ayatModel = [];
    for (var i = 0; i < data; i++) {
      final result = boxAyatModel.getAt(i);
      ayatModel.add(result);
    }

    state = AsyncData(ayatModel);
  }

  addData({required AyatModel ayatModel}) async {
    final splitIndonesia = ayatModel.teksIndonesia.split('');
    final resultIndonesia = splitIndonesia[0];
    final splitArab = ayatModel.teksArab.split('');
    final resultArab = splitArab[0];
    await boxAyatModel.put(
        "$resultIndonesia$resultArab",
        ayatModel.copyWith(
          nomorAyat: ayatModel.nomorAyat,
          teksArab: ayatModel.teksArab,
          teksIndonesia: ayatModel.teksIndonesia,
          audio: ayatModel.audio,
          isSelected: true,
        ));

    refreshData();
  }

  delete({required int id}) async {
    boxAyatModel.deleteAt(id);
    refreshData();
  }
}
