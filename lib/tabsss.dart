import 'package:flutter/material.dart';
import 'package:project/profile_page.dart';
import 'package:project/QR_scan.dart';
import 'package:project/history.dart';

class Tabs extends StatefulWidget {
  final String id;
  const Tabs({Key? key, required this.id}) : super(key: key);
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  late TabController controller;
  String id = "";
  int count = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    id = widget.id;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF4c1130),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: Material(
          color: Color(0xFF4c1130),
          child: TabBar(
            controller: controller,
            tabs: const [
              Tab(text: 'Profile', icon: Icon(Icons.account_circle)),
              Tab(text: 'QR Scan', icon: Icon(Icons.camera_alt)),
              Tab(text: 'History', icon: Icon(Icons.event_note_outlined)),
            ],
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: [
            ProfilePage(id: id),
            QRScan(),
            History(id: id),
          ],
        ));
  }
}
