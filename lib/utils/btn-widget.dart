import 'package:flutter/material.dart';

import 'color.dart';


class ButtonWidget extends StatelessWidget {
  var btntext;
  var onclick;

  ButtonWidget({this.btntext, this.onclick});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onclick ,
      child: Container(
        margin: EdgeInsets.only(top: 20),
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [orangecolors, orangecolorslight],
                end: Alignment.centerLeft,
                begin: Alignment.centerRight),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        alignment: Alignment.center,
        child: Text(
          btntext,
          style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
