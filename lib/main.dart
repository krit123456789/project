import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/global.dart';
import 'package:project/myConstant.dart';
import 'package:project/register.dart';
import 'package:project/splashpage.dart';
import 'package:project/tabsss.dart';
import 'package:project/Model/usermodel.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splashpage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserModel? user;

  @override
  void initState() {
    super.initState();
    nameController.text = "n";
    passwordController.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFd2bad6),
      appBar: AppBar(
        backgroundColor: Color(0xFF4c1130),
        title: Text(
          'Material managing system',
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: Stack(
            children: [
              Positioned(
                width: MediaQuery.of(context).size.width,
                top: MediaQuery.of(context).size.height / 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Image.asset('assets/mainProfile.png'),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 20.0, left: 40.0, right: 40.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter username";
                              } else if (value.length > 15) {
                                return "Please enter username between 1-15 characters";
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4c1130),
                                )),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter password";
                              } else if (value.length > 15) {
                                return "Please enter password between 1-15 characters";
                              }
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4c1130),
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      width: 80.w,
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            login();
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Tabs(id: "1")),
                            );*/
                          }
                        },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4c1130),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: 80.w,
                      padding: EdgeInsets.symmetric(vertical: 0.0),
                      child: ElevatedButton(
                        child: Text(
                          'REGISTER',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4c1130)),
                      ),
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

  Future login() async {
    String id = "";
    String name = nameController.text;
    String password = passwordController.text;
    String path =
        '${MyConstant.domain}/api_nont_demo/login.php?username=$name&password=$password';
    await Dio().get(path).then((value) {
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          user = UserModel.fromMap(item);
          id = user!.account_id;
          Global.userid = user!.account_id;
          Global.his_short_name = user!.short_name;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Tabs(id: id)),
          );
        }
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Wrong username or password'),
                ));
      }
    });
  }
}
