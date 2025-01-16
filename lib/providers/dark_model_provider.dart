import 'package:al_quran/hive_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dark_model_provider.g.dart';

@Riverpod(keepAlive: true)
class DarkModel extends _$DarkModel {
  @override
  Future<bool> build() async {
    final data = await boxIsDark.get(1);
    if (data == null) {
      return false;
    } else {
      return data;
    }
  }

  refreshData({required bool value}) async {
    await boxIsDark.put(1, value);
    state = AsyncData(value);
  }
}
