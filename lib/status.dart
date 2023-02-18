import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/cars.dart';
import 'package:untitled1/profile.dart';
import 'tools/constThing.dart';
import 'tools/constClass.dart';
import 'tabbar.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cars.dart';

var themeofdate = (context, child) {
  return Theme(
    data: Theme.of(context).copyWith(
      colorScheme: ColorScheme.light(
        primary: Color(0xFFE95321), // header background color
        onPrimary: Color(0xFF10132E), // header text color
        onSurface: Colors.green, // body text color
      ),
    ),
    child: child!,
  );
};

class StatusOfPark extends StatefulWidget {

  const StatusOfPark({Key? key}) : super(key: key);

  @override
  State<StatusOfPark> createState() => _StatusOfParkState();
}

class _StatusOfParkState extends State<StatusOfPark> {

  TextEditingController day1Controller = TextEditingController();
  TextEditingController day2Controller = TextEditingController();
  TextEditingController carIdController = TextEditingController();
  TextEditingController hour1Controller= TextEditingController();
  TextEditingController hour2Controller = TextEditingController();


  DateTime date = DateTime.now();
  DateTime date1 = DateTime.now();
  DateTime date2 = DateTime.now();
  DateTime date3 = DateTime.now();
  reserVation(int car,String year1, month1, day1, hour1, minute1, year2, month2, day2, hour2, minute2) async {
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString("Authorization");

    try {
      Response respone = await post(
          Uri.parse('http://gopark-syr.herokuapp.com/park/api/add'),
          headers: {
            "Authorization": 'Token $action',
          },
          body: {
            'car_id': car.toString(),
            'entry_date': "${year1}-${month1}-${day1}",
            'entry_time': "${hour1}:${minute1}",
            'end_date': "${year2}-${month2}-${day2}",
            'end_time':"${hour2}:${minute2}",

          }
      );
      print("mdfdf");
      print(respone.statusCode);
      if(respone.statusCode==200)
        {
          print("ndknfjdf");
          var res=jsonDecode(respone.body);
          print(res['Message']);
          showAboutDialog(context: context,
            applicationIcon: Icon(Icons.price_change),
            applicationName: 'Your reservation information',
            children: <Widget>[
              Text("Message: ${res['Message']}"),
              Text("Cost: ${res['parking_cost']}"),
              Text("Flote: flot 4")
            ],

           );
        }
    } catch(e) {

      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(

              child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/nban.png'), fit: BoxFit.fitWidth),
                color: Color(0xFF123456),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
          )),
          Expanded(
            child:SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: leftMargine, top: 10),
                child: Text(
                  "Select Time",
                  style: Ktextstyle,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Timestartandend("Start Time"),
                    SizedBox(width: 70),
                    Timestartandend("End Time"),
                  ],
                ),
              ),
              Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 12),
                        child: ElevatedButton(
                          style: timeStyle,
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2100),
                                builder: themeofdate);

                            if (newDate == null) return;
                            TimeOfDay? newTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                    hour: date.hour, minute: date.minute),
                                builder: themeofdate);
                            if (newTime == null) return;

                            final newDateTime = DateTime(
                              newDate.year,
                              newDate.month,
                              newDate.day,
                              newTime.hour,
                              newTime.minute,
                            );

                            setState(() {
                              date = newDateTime;
                            });
                          },
                          child: Text(
                            '${date.day}/${date.month}/${date.year} - ${date.hour} :${date.minute}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 12),
                        child: ElevatedButton(
                          style: timeStyle,
                          onPressed: () async {
                            DateTime? newDate1 = await showDatePicker(
                                context: context,
                                initialDate: date1,
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2100),
                                builder: themeofdate);
                            if (newDate1 == null) return;
                            TimeOfDay? newTime1 = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                    hour: date1.hour, minute: date1.minute),
                                builder: themeofdate);
                            if (newTime1 == null) return;

                            final newDateTime1 = DateTime(
                              newDate1.year,
                              newDate1.month,
                              newDate1.day,
                                newTime1.hour,
                                newTime1.minute
                            );

                            setState(() {
                              date1 = newDateTime1;
                            });
                          },
                          child: Text(
                            '${date1.day}/${date1.month}/${date1.year} - ${date1.hour} :${date1.minute}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap:(){
                  print(date.toString());
                  print(date3.toString());
                 reserVation(1,date.year.toString(), date.month.toString(),
                     date.day.toString(), date.hour.toString()
                     ,date.minute.toString(), date1.year.toString(), date1.month.toString(),
                     date1.day.toString(), date1.hour.toString(),date1.minute.toString());
                },
                /* onTap: (){
                        login(emailController.text.toString(), passwordController.text.toString());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => testpage(),
                            ));
                      },*/
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color:  Color(0xFFE95321),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text('Get Start'),),
                ),
              ),
            ],
          ),
            ),
          ),
        ],
      )),
    );
  }
}
