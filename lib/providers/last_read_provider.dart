import 'package:al_quran/hive_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'last_read_provider.g.dart';

@Riverpod()
class LastRead extends _$LastRead {
  @override
  Future<String> build() async {
    final data = await boxlastRead.get(1);
    if (data == null) {
      return "Al-Fatihah";
    } else {
      return data;
    }
  }

  void refreshData({required String namaSurat}) async {
    await boxlastRead.put(1, namaSurat);
    state = AsyncData(namaSurat);
  }
}
