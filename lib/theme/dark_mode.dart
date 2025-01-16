import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.black,
  ),

  // bottom navbar
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color(0xff682ebc),
    backgroundColor: Colors.black,
    selectedIconTheme: IconThemeData(
      color: Color(0xff682ebc),
    ),
  ),

  // appbar
  appBarTheme: const AppBarTheme(color: Colors.black),

  // scaffold
  scaffoldBackgroundColor: Colors.black,

  // color app
  colorScheme: ColorScheme(
    brightness: Brightness.dark,

    // use
    primary: const Color(0xff682ebc),
    secondary: Colors.white,
    secondaryContainer: Colors.grey.shade900,

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
