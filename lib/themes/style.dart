import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'Kanit',
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.blueAccent, // Your accent color
    ),
    buttonColor: Colors.lightBlue,
  );
}
