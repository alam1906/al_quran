import 'package:al_quran/models/surat_model.dart';
import 'package:al_quran/controllers/surat_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'all_surat_provider.g.dart';

@Riverpod(keepAlive: true)
class AllSurat extends _$AllSurat {
  @override
  Future<List<SuratModel>> build() async {
    SuratController suratController = SuratController();
    final data = await suratController.getAllSuratLokal();
    return data;
  }

  searchController({required String text, bool isDelete = false}) async {
    if (text.isEmpty) {
      refreshData();
    } else {
      SuratController suratController = SuratController();
      final reset = await suratController.getAllSuratLokal();
      state = AsyncData(reset);
      final data = state.value!
          .where(
              (e) => e.namaLatin.toLowerCase().startsWith(text.toLowerCase()))
          .toList();
      state = AsyncData(data);
    }
  }

  refreshData() async {
    SuratController suratController = SuratController();
    final data = await suratController.getAllSuratLokal();
    state = AsyncData(data);
  }
}
