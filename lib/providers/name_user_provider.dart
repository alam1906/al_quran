import 'package:al_quran/hive_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'name_user_provider.g.dart';

@Riverpod(keepAlive: true)
class NameUser extends _$NameUser {
  @override
  String build() {
    final data = boxName.get('name');
    if (data == null) {
      return "Anonymous";
    } else {
      return data;
    }
  }

  void setName({required String name}) {
    boxName.put('name', name);
    state = name;
  }
}
