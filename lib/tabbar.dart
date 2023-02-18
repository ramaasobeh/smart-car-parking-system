import 'package:flutter/material.dart';
import 'home.dart';
import 'status.dart';
import 'tools/constThing.dart';
import 'profile.dart';
import 'comment.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> with TickerProviderStateMixin {
  late TabController controller;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFE95321),
          title: Center(
              child: Text(
            'Go Park',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          )),
          bottom: TabBar(
            controller: controller,
            isScrollable: false,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)), // Creates border
                color: Colors.white),
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.home,
                  color: Color(0xFF10132E),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.safety_divider,
                  color: Color(0xFF10132E),
                ),
              ),
              Tab(
                icon: Icon(Icons.signal_wifi_statusbar_null,
                    color: Color(0xFF10132E)),
              ),
              Tab(
                icon: Icon(Icons.brightness_5_sharp, color: Color(0xFF10132E)),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: <Widget>[
            Center(
              child: Home(),
            ),
            Center(
              child: StatusOfPark(),
            ),
            Center(
              child: POP(),
            ),
            Center(
              child: CostumProfile(),
            ),
          ],
        ),
      ),
    );
    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }
  }
}
