import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/tools/constThing.dart';
import 'tools/constansofprofile.dart';
import 'tools/constThing.dart';
import './tools/constClass.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:untitled1/cars.dart';
import 'package:untitled1/profile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyCars extends StatefulWidget {
  const MyCars({Key? key}) : super(key: key);

  @override
  State<MyCars> createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  var p = Icon(Icons.car_rental);
  late List<Car> list;
  bool loade = true;

  @override
  void initState() {
    super.initState();
    inFun();
  }

  void inFun() async {
    list = await fetchCar();
    setState(() {
      loade = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SingleChildScrollView(
        child: (loade == true)
            ?const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Color(0xFF123456),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("My Cars", style: kTitleTextStyle),
                              Text("Normal User",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      wordSpacing: 2.5)),
                            ],
                          ),
                          Icon(Icons.car_rental,
                              color: Color(0xFFFFC107), size: 40),
                        ],
                      )),
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(4),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          trailing: Text(
                            list[index].id.toString(),
                            style: TextStyle(color: Colors.green, fontSize: 20),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                list[index].brand.name +
                                    " - " +
                                    list[index].brand.model,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                list[index].color.toString(),
                                style: TextStyle(color: Colors.black54, fontSize: 20),
                              ),
                            ],
                          ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                  ),
                ],
              ),
      )),
    );
  }
}

Future<List<Car>> fetchCar() async {
  final prefs = await SharedPreferences.getInstance();
  final String? action = prefs.getString("Authorization");
  final response = await http.get(
      Uri.parse('http://gopark-syr.herokuapp.com/cars/api/my-cars'),
      headers: {
        "Authorization": 'Token $action',
      });
  if (response.statusCode == 200) {
    List<dynamic> body = convert.jsonDecode(response.body);
    List<Car> cars = body.map((dynamic item) => Car.fromJson(item)).toList();
    return cars;
  } else {
    throw Exception('Failed to load Car');
  }
}

class Car {
  final int id;
  final Brand brand;
  final String plat;
  final String color;

  const Car({
    required this.id,
    required this.brand,
    required this.plat,
    required this.color,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json["id"] as int,
      brand: Brand.fromJson(json["brand"]),
      plat: json["plate_number"] as String,
      color: json["color"] as String,
    );
  }
}

class Brand {
  final int id;
  final String name;
  final String model;

  const Brand({
    required this.id,
    required this.name,
    required this.model,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
        id: json["id"] as int,
        name: json["name"] as String,
        model: json["model"] as String);
  }
}
