import 'package:flutter/material.dart';
const double leftMargine = 13.0;
const Ktextstyle = TextStyle(
    color: Color(0xFF10132E),
    fontSize: 20,
    fontFamily: 'StickNoBills',
    fontWeight: FontWeight.bold);

const Ktextstyleprice = TextStyle(
    color: Color(0xFFE95321),
    fontSize: 21,
    fontFamily: 'OleoScriptSwashCaps',
    fontWeight: FontWeight.bold);

var timeStyle = ElevatedButton.styleFrom(
primary: Color(0xFFE95321),
padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 2),
shape:
RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));


InputDecoration buildInputDecoration(IconData icons,String hinttext) {
  return InputDecoration(
    hintText: hinttext,
    prefixIcon: Icon(icons),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
          color: Colors.green,
          width: 1.5
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
        color: Color(0xFFE95321),
        width: 1.5,
      ),
    ),
    enabledBorder:OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
        color: Color(0xFFE95321),
        width: 1.5,
      ),
    ),
  );
}