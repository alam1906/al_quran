import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white,
  ),

  // bottom navbar
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color(0xff682ebc),
    backgroundColor: Colors.white,
    selectedIconTheme: IconThemeData(
      color: Color(0xff682ebc),
    ),
  ),

  // appbar
  appBarTheme: const AppBarTheme(color: Colors.white),

  // scaffold
  scaffoldBackgroundColor: Colors.white,

  // color app
  colorScheme: ColorScheme(
    brightness: Brightness.light,

    // use
    primary: const Color(0xff682ebc),
    secondary: Colors.black,
    secondaryContainer: Colors.grey.shade200,

    // not use
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    error: Colors.black,
    onError: Colors.black,
    surface: Colors.black,
    onSurface: Colors.black,
    primaryContainer: Colors.grey.shade900,
  ),
);
