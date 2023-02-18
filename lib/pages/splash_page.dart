import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/pages/loginpage.dart';
import 'package:untitled1/utils/color.dart';


class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState(){
    super.initState();
    Timer(const Duration(milliseconds: 4000), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [orangecolors, orangecolorslight],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter
          ),
        ),
        child: Center(
          child: Image.asset('images/test1.png'),
        ),
      ),
    );
  }
}
