import 'package:flutter/material.dart';
import './tools/constThing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameContoller=TextEditingController();
  TextEditingController modelController=TextEditingController();
  TextEditingController platnumberController=TextEditingController();
  TextEditingController colorController=TextEditingController();

  void addCar(String name ,model, plat_number, color) async{
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString("Authorization");
    try {

      Response respone = await post(
          Uri.parse('http://gopark-syr.herokuapp.com/cars/api/add'),
          headers: {
            "Authorization": 'Token $action',
          },
          body: {
            'name': name,
            'model': model,
            'plate_number':plat_number,
            'color':color
          }
      );
      print(respone.statusCode);
      if(respone.statusCode==200){
        var s=respone.body.toString();
        print(s);
        print(respone.body.toString());
      }

      }catch(e) {
      print(e.toString());
    }
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom:15,left: 10,right: 10),
                  child: TextFormField(
                    controller:nameContoller ,
                    keyboardType: TextInputType.text,
                    decoration: buildInputDecoration(Icons.brightness_auto_sharp,"Brand Name"),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:15,left: 10,right: 10),
                  child: TextFormField(
                    controller:modelController,
                    keyboardType: TextInputType.text,
                    decoration: buildInputDecoration(Icons.brightness_auto_outlined,"Model"),

                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
                  child: TextFormField(
                    controller:platnumberController ,
                    keyboardType: TextInputType.number,
                    decoration:buildInputDecoration(Icons.airplay_rounded,"Plat Number"),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
                  child: TextFormField(
                    controller:colorController ,
                    keyboardType: TextInputType.text,
                    decoration:buildInputDecoration(Icons.palette_rounded,"Color"),

                  ),
                ),
                GestureDetector(
                  onTap:(){
                    addCar(nameContoller.text.toString(),
                        modelController.text.toString(), platnumberController.text.toString(),
                        colorController.text.toString());
                  },

                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color:  Color(0xFFE95321),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(child: Text('Submit'),),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}




