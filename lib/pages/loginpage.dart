import 'dart:convert';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../utils/color.dart';
import 'regpage.dart';
import '../utils/header.dart';
import 'package:http/http.dart';
import 'package:untitled1/home.dart';
import 'package:untitled1/tabbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  void _togglePasswordView(){

    setState(() {
      hidePassword =! hidePassword;
    });
  }
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoding= false;
  void login(String username ,password) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      Response respone = await post(
          Uri.parse('http://gopark-syr.herokuapp.com/users/api/login'),
          body: {
            'username': username,
            'password': password
          }
      );
      if(respone.statusCode==200){
        var data= jsonDecode(respone.body.toString());
        print('token :');
        print(data['token']);
        print('message :');
        print(data['message']);
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
          _isLoding =false;
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              HeaderContainer("GoPark"),
              Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        child: TextFormField(
                          controller:emailController ,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_circle_outlined),
                              hintText: 'User Name'
                          ),
                        ),
                      ),
                      Container(
                        child: TextFormField(
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
                      ),

                      SizedBox(height: 30,),
                      GestureDetector(
                        onTap: emailController.text == ""|| passwordController.text==""
                            ? null
                        :(){
                          setState(() {
                            _isLoding= true;
                          });
                          login(emailController.text.toString(), passwordController.text.toString());
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
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(child: Text('Login'),),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account ?",
                              style: TextStyle(color: Colors.black)),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Register(),
                                  ));
                            },
                            child: const Text('Register',
                                style:
                                TextStyle(fontSize: 18, color:Color(0xFFE95321))),
                          ),
                        ],
                      ),
                      // RichText(
                      //     text: TextSpan(children: [
                      //   TextSpan(
                      //       text: "Don't have an account ?   ",
                      //       style: TextStyle(color: Colors.black)),
                      //
                      //   TextSpan(
                      //       text: "Register",
                      //       ),
                      // ]))
                    ],
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
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

Widget loginadd(text) {
  return Container(
    margin: EdgeInsets.only(top: 10),
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
      text,
      style: TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
