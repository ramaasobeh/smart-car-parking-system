import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './constansofprofile.dart';
import './constThing.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

//For Status Page



class PPP extends StatelessWidget {
  var fontstyle, text1, text2, text3, m1, m2;

  PPP({this.fontstyle, this.text1, this.text2, this.text3, this.m1, this.m2});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: m1, right: m2),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text1, textAlign: TextAlign.start, style: fontstyle),
          Text(text2, textAlign: TextAlign.center, style: fontstyle),
          Text(text3, textAlign: TextAlign.start, style: fontstyle),
        ],
      ),
    );
  }
}

//For Time Button
class TimeButton extends StatelessWidget {
  var timenumber;

  TimeButton({this.timenumber});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Color(0xFFE95321),
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Text(
        timenumber,
        style: TextStyle(fontSize: 21),
      ),
      onPressed: () {},
    );
  }
}

class Timestartandend extends StatelessWidget {
  var text;
  Timestartandend(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30),
      child: Text(text,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22)),
    );
  }
}



class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final text;
  final bool hasNavi;

  ProfileListItem({
    Key? key,
    this.text,
    required this.icon,
    this.hasNavi = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: kSpacingUnit.w * 5,
        margin: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 4)
            .copyWith(bottom: kSpacingUnit.w * 2),
        padding: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kSpacingUnit.w * 1.5),
          color: Color(0xFFE95321),
        ),
        child: Row(children: [
          Icon(this.icon, size: kSpacingUnit.w * 2.5),
          SizedBox(width: kSpacingUnit.w * 2.5),
          Text(this.text,
              style: kTitleTextStyle.copyWith(fontWeight: FontWeight.w500)),
          Spacer(),
          Icon(LineAwesomeIcons.angle_right, size: kSpacingUnit.w * 2.5),
        ]),
      ),
    );
  }
}