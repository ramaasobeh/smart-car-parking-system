import 'dart:async';
import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:untitled1/cars.dart';
import 'package:untitled1/pages/loginpage.dart';
import 'package:untitled1/pages/splash_page.dart';
import 'package:untitled1/test.dart';
import 'tools/constansofprofile.dart';
import './tools/constClass.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
//import 'widgets/profile_list_item.dart';

class CostumProfile extends StatelessWidget {

  const CostumProfile({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: kDarkTheme,
      home: Profile(),
    );

  }
  void logout() async {
    try {
      Response respone = await post(
          Uri.parse('http://gopark-syr.herokuapp.com/users/api/logout'),);

      if(respone.statusCode==200){

      }
    }
    catch(e) {
      print(e.toString());
    }

  }
}


class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    var profile = Expanded(
      child: Column(
        children: [
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: [
                CircleAvatar(
                    radius: kSpacingUnit.w * 5,
                    backgroundImage: AssetImage('images/yamen.png'),
                    backgroundColor: Colors.white),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: kSpacingUnit.w * 2.5,
                    height: kSpacingUnit.w * 2.5,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        shape: BoxShape.circle),
                    child: Icon(
                      LineAwesomeIcons.pen,
                      color: kDarkPrimaryColor,
                      size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                    ),
                  ),
                )
              ],
            ),
          ),

          SizedBox(height: kSpacingUnit.w * 2),
          Container(
            child: FutureBuilder<Data>(
              future: fetchData(),
              builder: ( context,snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.first_name+" "+snapshot.data!.lastt_name,style: kTitleTextStyle);
                    }//
                 else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
          //Text("Yamen Gajery", style: kTitleTextStyle),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Container(
            child: FutureBuilder<Data>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.email, style: kCaptionTextStyle);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
         // Text("www.Yamen@gmail.com", style: kCaptionTextStyle),
          SizedBox(height: kSpacingUnit.w * 2),
          Container(
            height: kSpacingUnit.w * 3,
            width: kSpacingUnit.w * 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  kSpacingUnit * 5,
                ),
                color: Theme.of(context).accentColor),
            child: Center(
                child: Text(
              "Upgrade to VIP",
              style: kButtonTextStyle,
            )),
          )
        ],
      ),

    );
    var header = Container(
        height: 320,
        decoration: BoxDecoration(
            color: Color(0xFF123456),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: kSpacingUnit.w * 3),
            profile,
            SizedBox(width: kSpacingUnit.w * 3),
          ],
        )
    );
    var logout = RaisedButton(
      color: Colors.white,
      onPressed:() async {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.clear();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
                (Route<dynamic>route) => false);
      },
      child: Container(
        height: kSpacingUnit.w * 5,
        margin: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 4)
            .copyWith(bottom: kSpacingUnit.w * 2),
        padding: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
          color: Color(0xFFE95321),
        ),
        child: Row(children: [
          Icon(LineAwesomeIcons.history, size: kSpacingUnit.w * 2.5),
          SizedBox(width: kSpacingUnit.w * 2.5),
          Text("log out",
              style: kTitleTextStyle.copyWith(fontWeight: FontWeight.w500)),
          Spacer(),
          Icon(LineAwesomeIcons.angle_right, size: kSpacingUnit.w * 2.5),
        ]),
      ),
    );
    var timeline = RaisedButton(
      color: Colors.white,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => History(),));
      },
      child: Container(
        height: kSpacingUnit.w * 5,
        margin: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 4)
            .copyWith(bottom: kSpacingUnit.w * 2),
        padding: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
          color: Color(0xFFE95321),
        ),
        child: Row(children: [
          Icon(LineAwesomeIcons.history, size: kSpacingUnit.w * 2.5),
          SizedBox(width: kSpacingUnit.w * 2.5),
          Text("Car History",
              style: kTitleTextStyle.copyWith(fontWeight: FontWeight.w500)),
          Spacer(),
          Icon(LineAwesomeIcons.angle_right, size: kSpacingUnit.w * 2.5),
        ]),
      ),
    );
    var mycar = RaisedButton(
      color: Colors.white,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyCars(),));
      },
      child: Container(
        height: kSpacingUnit.w * 5,
        margin: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 4)
            .copyWith(bottom: kSpacingUnit.w * 2),
        padding: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
          color: Color(0xFFE95321),
        ),
        child: Row(children: [
          Icon(LineAwesomeIcons.car_side, size: kSpacingUnit.w * 2.5),
          SizedBox(width: kSpacingUnit.w * 2.5),
          Text("MyCars",
              style: kTitleTextStyle.copyWith(fontWeight: FontWeight.w500)),
          Spacer(),
          Icon(LineAwesomeIcons.angle_right, size: kSpacingUnit.w * 2.5),
        ]),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        header,
        Expanded(
            child: ListView(
          children: [
            mycar,
            timeline,
            logout,

          ],
        )),
      ]
      ),
    );
  }
}

Future<Data> fetchData() async {
  final prefs = await SharedPreferences.getInstance();
  final String? action = prefs.getString("Authorization");
  final response = await http.get(Uri.parse('http://gopark-syr.herokuapp.com/users/api/myinfo'), headers: {
    "Authorization": 'Token $action',
  });
  if (response.statusCode == 200) {
    Data res =  Data.fromJson(convert.jsonDecode(response.body));
    return res;

  } else {
    throw Exception('Failed to load Data');
  }
}

class Data {
  final String first_name;
  final String lastt_name;
  final String username;
  final String email;
  final String password;
  final String phone_number;

  const Data({
    required this.first_name,
    required this.lastt_name,
    required this.username,
    required this.email,
    required this.password,
    required this.phone_number,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      first_name: json["first_name"] as String,
      lastt_name: json["lastt_name"]as String,
      email: json["email"]as String,
      username: json["username"]as String,
      password: json["password"]as String,
      phone_number: json["phone_number"]as String,

    );
  }
}

