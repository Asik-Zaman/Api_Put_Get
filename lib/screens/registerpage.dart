import 'package:flutter/material.dart';

import 'package:loginui/screens/api_model.dart';
import 'package:loginui/screens/dashboard.dart';

class registerpage extends StatefulWidget {
  const registerpage({Key? key}) : super(key: key);

  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {
  final emailText = TextEditingController();
  final passwordText = TextEditingController();
  bool isLoading = false;

  //MARK:API Call
  callLoginApi() {
    final service = ApiServices();

    service.apiCallLogin(
      {
        "email": emailText.text,
        "password": passwordText.text,
      },
    ).then((value) {
      if (value.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Bad Request"),
        ));
        print("get data >>>>>> " + value.error!);
      } else {
        //print(value.token!);
        setState(() {
          isLoading = true;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(
                token: value.token,
                email: value.email,
                phone: value.phone,
                username: value.username,
              ),
            ),
            (route) => false);
      }
    });
  }

  //token: value.token!
  /* Future<void> getPage() async {
    Center(
      child: CircularProgressIndicator(),
    );
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Dashboard()));
  } */

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Container(
        height: height,
        width: width,
        color: Colors.amberAccent,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: height * .40,
                    left: width * .05,
                    right: width * .05,
                    bottom: height * .40),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailText,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade300,
                          filled: true,
                          hintText: "Phone",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: passwordText,
                      style: TextStyle(),
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade300,
                          filled: true,
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  callLoginApi();
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
