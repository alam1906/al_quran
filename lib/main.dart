import 'package:al_quran/hive_data.dart';
import 'package:al_quran/models/ayat_model.dart';
import 'package:al_quran/providers/dark_model_provider.dart';
import 'package:al_quran/theme/dark_mode.dart';
import 'package:al_quran/theme/ligth_mode.dart';

import 'package:al_quran/views/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: library_prefixes
import 'package:path_provider/path_provider.dart' as pathProvider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocument = await pathProvider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocument.path);
  Hive.registerAdapter(AyatModelAdapter());
  boxAyatModel =
      await Hive.openBox<AyatModel>('ayatModel', path: appDocument.path);
  boxIsDark = await Hive.openBox('isDark');
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(darkModelProvider).valueOrNull;
    if (data == null) {}
    return MaterialApp(
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: data == true ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
