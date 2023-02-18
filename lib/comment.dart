import 'package:flutter/material.dart';
import './tools/constThing.dart';

class POP extends StatefulWidget {
  const POP({Key? key}) : super(key: key);

  @override
  State<POP> createState() => _POPState();
}

class _POPState extends State<POP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
            RaisedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Stack(
                        children: [
                          Positioned(
                            right: -40.0,
                            top: -40.0,
                            child: InkResponse(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: CircleAvatar(
                                child: Icon(Icons.close),
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                          Form(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 200,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Write Your Feedback',
                                          border: OutlineInputBorder(),
                                        ),
                                        maxLines: 5, // <-- SEE HERE
                                        minLines: 1, // <-- SEE HERE
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    child: Text(
                                      "Send",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {},
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Text("Open Popup", style: TextStyle(fontSize: 50)),
          ),
        ]
        ),
      ),
    );
  }
}

class AddCAr extends StatefulWidget {
  const AddCAr({Key? key}) : super(key: key);

  @override
  State<AddCAr> createState() => _AddCArState();
}

class _AddCArState extends State<AddCAr> {
   late String name,email,phone;
    //TextController to read text entered in text field
    TextEditingController password = TextEditingController();
    TextEditingController confirmpassword = TextEditingController();

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
                      keyboardType: TextInputType.text,
                      decoration: buildInputDecoration(Icons.brightness_auto_sharp,"Brand Name"),

                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration:buildInputDecoration(Icons.airplay_rounded,"Plat Number"),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration:buildInputDecoration(Icons.palette_rounded,"Color"),

                    ),
                  ),

                  SizedBox(
                    width: 200,
                    height: 50,
                    child: RaisedButton(
                      color: Color(0xFFE95321),
                      onPressed: (){
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: Color(0xFFE95321),width: 2)
                      ),
                      textColor:Colors.white,child: Text("Submit",style: TextStyle(fontSize: 25)),

                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }
}
