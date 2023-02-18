import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../utils/btn-widget.dart';
import '../utils/color.dart';
import 'package:untitled1/home.dart';
import '../utils/header.dart';
import 'package:untitled1/tabbar.dart';

import 'loginpage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool hidePassword = true;
  void _togglePasswordView(){

    setState(() {
      hidePassword =! hidePassword;
    });
  }
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoding= false;
  var token;

  void register(String firstname ,lastname ,username ,email ,password,phonenumber) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      Response respone = await post(
          Uri.parse('http://gopark-syr.herokuapp.com/users/api/register'),

          body: {
            "username": username,
            "email": email,
            "first_name": firstname,
            "last_name": lastname,
            "phone_number": phonenumber,
            "password": password
          }

      );
      if(respone.statusCode==400){
        var data= jsonDecode(respone.body.toString());
        print(respone.statusCode);
        print(data);
        print(data['message']);
        token=data['token'];
        if(data != null)
        {
          setState(() {
            _isLoding=false;
          });

            sharedPreferences.setString("Authorization", data['token']);
                    Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => Tabbar()),
                  (Route<dynamic>route) => false);
        }


      }else{
        setState(() {
          _isLoding=false;
        });
        Text(respone.body);
      }
    } catch(e) {
      print(e.toString());
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Column(
          children: [
            HeaderContainer("GoPark"),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child:Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextFormField(
                      controller:firstNameController ,

                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'First Name'
                      ),
                    ),
                    TextFormField(
                      controller:lastNameController ,

                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Last Name'
                      ),
                    ),
                    TextFormField(
                      controller:userNameController ,

                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle_rounded),
                          hintText: 'User Name'
                      ),
                    ),
                    TextFormField(
                      controller:emailController ,

                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Email'
                      ),
                    ),
                    TextFormField(
                      controller:phoneNumberController ,

                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.add_call),
                          hintText: 'Phone Number'
                      ),
                    ),
                  TextFormField(
                    obscureText: hidePassword,

                    controller:passwordController ,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.key),
                        hintText: 'Password',
                        suffixIcon: InkWell(
                            onTap: _togglePasswordView,
                            child: Icon(Icons.visibility))
                    ),
                  ),

                  SizedBox(height: 30,),
                    GestureDetector(
                      onTap: emailController.text == ""|| passwordController.text==""||userNameController.text=="" ||
                          phoneNumberController.text==""||firstNameController.text==""||lastNameController.text==""
                          ? null
                          :(){
                        setState(() {
                          _isLoding= true;
                        });
                        register(firstNameController.text.toString(), lastNameController.text.toString(), userNameController.text.toString()
                            , emailController.text.toString(), passwordController.text.toString(),
                            phoneNumberController.text.toString());
                      },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text('Rigester'),),
                    ),
                  ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account",
                            style: TextStyle(color: Colors.black)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                          },
                          child: const Text('Login',
                              style:
                              TextStyle(fontSize: 18, color:Color(0xFFE95321))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ),
          ],
            ),
      ),
    );
  }

  Widget _textInput(hint, icon) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        //controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
