import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFE9896A),
    secondary: Color(0xFFFBE6C2),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Color(0xFF343F56), fontSize: 14.0),
    button: TextStyle(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        padding: const EdgeInsets.all(16.0)),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(color: Color(0xFFE9896A)),
    centerTitle: true,
    elevation: 0,
    titleTextStyle: TextStyle(
        color: Color(0xFF343F56), fontSize: 18.0, fontWeight: FontWeight.bold),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Color(0xFFE9896A),
    indicatorSize: TabBarIndicatorSize.tab,
    unselectedLabelColor: Colors.grey,
    indicator: BoxDecoration(),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: const Color(0xFFE9896A),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 4,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color(0xFFE9896A),
    enableFeedback: true,
    showUnselectedLabels: true,
    showSelectedLabels: true,
  ),
  cardTheme: CardTheme(
    elevation: 4.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
  ),
);
