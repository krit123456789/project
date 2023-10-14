import 'package:flutter/material.dart';
import 'package:project/QR_camera.dart';
import 'package:project/main.dart';
import 'package:project/QR_camera.dart';
import 'package:project/Material_picking.dart';
import 'package:project/select_category.dart';

class QRScan extends StatefulWidget {
  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFd2bad6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRCamera()),
                );
              },
              child: Text('Scan QR'),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(100, 50),
                primary: Color(0xFF4c1130),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectCategory()),
                );
              },
              child: Text('Supply List'),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(130, 50),
                primary: Color(0xFF4c1130),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
