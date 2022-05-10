import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loginui/constant/sizedbox.dart';
import 'package:loginui/screens/registerpage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  final String? token;
  final dynamic username;
  final dynamic email;
  final dynamic phone;

  Dashboard({
    Key? key,
    this.username,
    this.phone,
    this.email,
    this.token,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? value;
  Future<void> fetchExpense() async {
    final response = await http
        .get(Uri.parse('http://mamun.click/api/auth/expense/show'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $value',
    });
    print(value);

    // print('Token : ${token}');
    var expenseData = jsonDecode(response.body);

    print(expenseData);
  }

  /*  Future<void> fetchMenu() async {
    var token = '8440|RjqHhoRIIEOvAOmn66tw5iUHTSr3E3IgTfVEu84d';
    final response = await http.get(
        Uri.parse('https://khelaahobe.com//api//auth//flutter//set//menu//'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    print('Token : ${token}');
    var menuData = jsonDecode(response.body);

    print(menuData);
  } */
  Future<void> setTokenValue(token) async {
    SharedPreferences.setMockInitialValues({});
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('tokenValue', token);
    print(token);
  }

  void getTokenValue() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    value = pref.getString('tokenValue');
    print('Token is : ' + value.toString());
  }
/* 
  @override
  void initState() {
    setTokenValue(widget.token);
    getTokenValue();
    fetchExpense();
    //fetchMenu();
    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text('User Profile'),
        centerTitle: true,
        actions: [
          OutlinedButton.icon(
              style: OutlinedButton.styleFrom(primary: Colors.pink),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => registerpage(),
                    ),
                    (route) => false);
                //Navigator.of(context).pop();
                /* Navigator.push(context,
                      MaterialPageRoute(builder: (context) => registerpage())); */
              },
              icon: Icon(
                Icons.exit_to_app,
                size: 18,
              ),
              label: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(
              width * .05, height * .05, width * .05, height * .05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 70,
                ),
                radius: 60,
              ),
              addVerticalSpace(25),
              Container(
                child: Text(
                  'Name : ' + widget.username.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              addVerticalSpace(10),
              Container(
                child: Text(
                  'Phone : ' + widget.phone.toString(),
                  style: TextStyle(fontSize: 20),
                ),
              ),
              addVerticalSpace(10),
              Container(
                child: Text(
                  'Email : ' + widget.email.toString(),
                  style: TextStyle(fontSize: 20),
                ),
              ),
              addVerticalSpace(10),
              Container(
                child: Text(
                  'Token : ' + widget.token.toString(),
                  style: TextStyle(fontSize: 20),
                ),
              ),
              addVerticalSpace(15),
              ElevatedButton(
                  onPressed: () {
                    setTokenValue(widget.token);
                  },
                  child: Text('Save Token')),
              ElevatedButton(
                  onPressed: () {
                    getTokenValue();
                  },
                  child: Text('Read Token')),
              ElevatedButton(
                  onPressed: () {
                    fetchExpense();
                  },
                  child: Text('Fetch Data'))
            ],
          ),
        ),
      ),
    );
  }
}
