import 'package:flutter/material.dart';

///Theme used in application.
ThemeData themes = ThemeData(
  fontFamily: 'Noyh',
  primaryColor: const Color(0xff47516C),
  accentColor: const Color(0xff363A44),
  brightness: Brightness.dark,
  iconTheme: IconThemeData(color: Colors.purple[300]),
  scaffoldBackgroundColor: const Color(0xff47516C),
  textTheme: TextTheme(
    button: TextStyle(color: Colors.red),
  ),
);
