import 'package:bank_app_alura/styles/colors_app.dart';
import 'package:flutter/material.dart';

abstract class ThemesApp {

  static final ThemeData primaryThemeApp = ThemeData(
    primaryColor: ColorsApp.primary,
    backgroundColor: ColorsApp.backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsApp.primary
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsApp.secundary
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ColorsApp.secundary)
      )
    ),
  );
}