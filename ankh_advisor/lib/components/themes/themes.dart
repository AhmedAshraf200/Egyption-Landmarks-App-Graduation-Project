import 'package:ankh_advisor/components/Constants.dart';
import 'package:ankh_advisor/serves/cache/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  cardTheme: const CardTheme(
      color:   Color(0xff252f47),
      elevation: 2,
      shadowColor: Colors.white
  ),
  scaffoldBackgroundColor:  const Color(0xff292238),
  primarySwatch: Colors.red,

  //floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
  appBarTheme:  const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
    //backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Color(0xff252f47),
    ),
    color: Color(0xff252f47),
    elevation: 0.0,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(CacheHelper.getData(key: 'color')?? Colors.blue.value),
      splashColor: Colors.red
  ),
  textTheme:  const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 20.0,
      color: Colors.white,
    ),
  ),
  fontFamily: 'Janna',
  cardColor: const Color.fromRGBO(66, 66, 66, 1.0),
);



ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  splashColor: Colors.red,
  primarySwatch: Colors.red,
  // floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w100,
      fontSize: 20.0,
      color: Colors.black,
    ),
  ) ,
  fontFamily: 'Janna',
  appBarTheme:  const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
    //backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      //statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ),
    color: Colors.white,
    elevation: 0.0,
  ),
  cardColor: Colors.white,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
    splashColor: Colors.red
  ),
);
