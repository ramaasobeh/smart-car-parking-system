import 'package:flutter/material.dart';
import 'tabbar.dart';
import 'package:untitled1/pages/splash_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
        fontFamily: 'StickNoBills',),
        home: SplashPage(),
    );
  }
}



