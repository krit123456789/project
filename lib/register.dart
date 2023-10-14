import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/Model/usermodel.dart';
import 'myConstant.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController shortnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFd2bad6),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF4c1130),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.pop(context)),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20.0, left: 40.0, right: 40.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter username";
                        } else if (value.length > 15) {
                          return "Please enter username between 1-15 characters";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Please fill in between 1-15 characters.",
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
                          hintText: "Please fill in between 1-15 characters.",
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4c1130),
                          )),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: confirmpasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter password";
                        } else if (value.length > 15) {
                          return "Please enter password between 1-15 characters";
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Please fill in between 1-15 characters.",
                          labelText: 'Confirm password',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4c1130),
                          )),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: firstnameController,
                      decoration: InputDecoration(
                          labelText: 'Firstname',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4c1130),
                          )),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: lastnameController,
                      decoration: InputDecoration(
                          labelText: 'Lastname',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4c1130),
                          )),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: shortnameController,
                      decoration: InputDecoration(
                          labelText: 'Shortname',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4c1130),
                          )),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20.0,
                        ),
                        Container(
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                checkPassword();
                              }
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(100, 50),
                              primary: Color(0xFF4c1130),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkPassword() {
    String password = passwordController.text;
    String confirmpassword = confirmpasswordController.text;
    if (password == confirmpassword) {
      checkUsername();
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Password not match'),
              ));
    }
  }

  Future checkUsername() async {
    String username = usernameController.text;
    String path =
        '${MyConstant.domain}/api_nont_demo/checkusername.php?username=$username';
    await Dio().get(path).then((value) {
      if (value.toString() == 'null') {
        register();
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('This name already exist'),
                ));
      }
    });
  }

  Future register() async {
    String username = usernameController.text;
    String password = passwordController.text;
    //String confirmpassword = confirmpasswordController.text;
    String first_name = firstnameController.text;
    String last_name = lastnameController.text;
    String short_name = shortnameController.text;
    String path =
        '${MyConstant.domain}/api_nont_demo/register.php?isAdd=true&username=$username&password=$password&firstname=$first_name&lastname=$last_name&shortname=$short_name';
    await Dio().get(path).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Register Successful'),
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('error'),
                ));
      }
    });
  }
}

Future<bool> deleteDialog(BuildContext context) {
  return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                  title: Text('Your account has been successfully created.'),
                  actions: [
                    TextButton(
                        child: Text('done'),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        }),
                  ]),
          barrierDismissible: true)
      .then((value) => value ?? false);
}
