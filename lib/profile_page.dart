import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/Model/usermodel.dart';
import 'package:project/global.dart';
import 'package:project/main.dart';
import 'package:project/myConstant.dart';

class ProfilePage extends StatefulWidget {
  final String id;
  const ProfilePage({Key? key, required this.id}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user;
  bool status = true;
  String id = "";

  @override
  void initState() {
    super.initState();
    Global.userid = widget.id;
    getData();
  }

  Future getData() async {
    id = widget.id;
    String path =
        '${MyConstant.domain}/api_nont_demo/ShowProfileName.php?id=$id';
    await Dio().get(path).then((value) {
      print(value.toString());
      if (value.toString() != "null") {
        for (var item in json.decode(value.data)) {
          user = UserModel.fromMap(item);
        }
        setState(() {
          status = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFd2bad6),
      body: status
          ? CircularProgressIndicator()
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'first name : ${user!.first_name}',
                    style: TextStyle(fontSize: 25.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'last name : ${user!.last_name}',
                    style: TextStyle(fontSize: 25.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Short name : ${user!.short_name}',
                    style: TextStyle(fontSize: 25.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4c1130)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "logout",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
