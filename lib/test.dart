import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import './tools/constThing.dart';
import 'package:timelines/timelines.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class History extends StatefulWidget {
  History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late List<resVation> list;
  bool loade = true;

  @override
  void initState() {
    super.initState();
    inFun();
  }

  void inFun() async {
    list = await getReservation();
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
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.all(4),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: Text(
                      list[index].status,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      "Reservation id:  ${list[index].id.toString()}",
                      style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 21
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "IN: ",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 20),
                            ),
                            Text(
                              "OUT: ",
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            Text(
                              list[index].entry_time,
                              style:
                                  TextStyle(color: Colors.green, fontSize: 20),
                            ),
                            Text(
                              list[index].end_time,
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            Text(
                              list[index].entry_date,
                              style:
                                  TextStyle(color: Colors.green, fontSize: 20),
                            ),
                            Text(
                              list[index].end_date,
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            ),
                          ],
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
      )

          /*Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: FutureBuilder<List<resVation>>(
                future: getReservation(),
                builder: (BuildContext context, snapshot) {
                  print(snapshot.data);
                  if (snapshot.hasData) {
                    List<resVation> resV = snapshot.data!;
                    return ListView(
                      children: resV
                          .map((resVation r) => ListView.builder(
                              itemCount: resV.length,
                              itemBuilder: (BuildContext context, int i) {
                                return ListTile(
                                    trailing: Text(
                                      r.status,
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 15),
                                    ),
                                    title: Text("car ${r.id.toString()}"));
                              }))
                          .toList(),
                    );
                  } else if (snapshot.hasError) {
                    print('${snapshot.error}');
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ],

          */ /*DataTable(columns: [
            DataColumn(
                label: Text(
              "Car",
              style: Ktextstyle,
            )),
            DataColumn(
                label: Text(
              "Date of start",
              style: Ktextstyle,
            )),
            DataColumn(
                label: Text(
                  "Date of end",
                  style: Ktextstyle,
                )),
            DataColumn(
                label: Text(
              "Plots",
              style: Ktextstyle,
            )),
          ], rows: [
            DataRow(cells: [
              DataCell(Text("BMW")),
              DataCell(Text("6/8/2022")),
              DataCell(Text("6/8/2022")),
              DataCell(Text("12")),
            ]),
            DataRow(cells: [
              DataCell(Text("BMW")),
              DataCell(Text("12/8/2022")),
              DataCell(Text("6/8/2022")),
              DataCell(Text("12")),
            ]),
            DataRow(cells: [
              DataCell(Text("BMW")),
              DataCell(Text("14/8/2022")),
              DataCell(Text("6/8/2022")),
              DataCell(Text("12")),
            ]),
            DataRow(cells: [
              DataCell(Text("BMW")),
              DataCell(Text("22/8/2022")),
              DataCell(Text("6/8/2022")),
              DataCell(Text("12")),
            ]),
            DataRow(cells: [
              DataCell(Text("BMW")),
              DataCell(Text("24/8/2022")),
              DataCell(Text("6/8/2022")),
              DataCell(Text("12")),
            ]),
          ]),*/ /*
        ),*/
          ),
    );
  }
}

Future<List<resVation>> getReservation() async {
  final prefs = await SharedPreferences.getInstance();
  final String? action = prefs.getString("Authorization");
  final response = await http.get(
      Uri.parse('http://gopark-syr.herokuapp.com/park/api/my-reservations'),
      headers: {
        "Authorization": 'Token $action',
      });
  if (response.statusCode == 200) {
    List<dynamic> body = convert.jsonDecode(response.body);
    List<resVation> resV =
        body.map((dynamic item) => resVation.fromJson(item)).toList();
    return resV;
  } else {
    throw Exception('Failed to load Car');
  }
}

class resVation {
  final int id;
  final String entry_date;
  final String entry_time;
  final String end_date;
  final String end_time;
  final int cost;
  final String status;

  const resVation({
    required this.id,
    required this.entry_date,
    required this.entry_time,
    required this.end_date,
    required this.end_time,
    required this.cost,
    required this.status,
  });

  factory resVation.fromJson(Map<String, dynamic> json) {
    return resVation(
      id: json["id"] as int,
      entry_date: json["entry_date"] as String,
      entry_time: json["entry_time"] as String,
      end_date: json["end_date"] as String,
      end_time: json["end_time"] as String,
      cost: json["cost"] as int,
      status: json["status"] as String,
    );
  }
}
