import 'package:flutter/material.dart';
import 'package:untitled1/utils/color.dart';

class HeaderContainer extends StatelessWidget {
  var text = "GoPark";

  HeaderContainer(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [orangecolors, orangecolorslight],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(children: [
        Positioned(
            bottom: 20,
            right: 20,
            child: Text(text,style: TextStyle(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold),)),
        Center(child: Image.asset('images/test1.png')),
      ]),
    );
  }
}
