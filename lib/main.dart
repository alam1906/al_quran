import 'package:al_quran/box_ayat_model.dart';
import 'package:al_quran/models/ayat_model.dart';

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

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
