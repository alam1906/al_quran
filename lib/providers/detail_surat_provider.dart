import 'package:al_quran/models/detail_surat_model.dart';
import 'package:al_quran/controllers/surat_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'detail_surat_provider.g.dart';

@Riverpod(keepAlive: true)
class DetailSurat extends _$DetailSurat {
  @override
  Future<DetailSuratModel> build(int nomor) async {
    SuratController suratController = SuratController();
    final data = await suratController.getDetailSuratLokal(nomor);
    return data;
  }
}
