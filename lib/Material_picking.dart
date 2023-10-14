import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/global.dart';
import 'package:project/myConstant.dart';
import 'package:project/tabsss.dart';

class MaterialPicking extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String number;
  final String source;
  const MaterialPicking(
      {Key? key,
      required this.id,
      required this.name,
      required this.image,
      required this.number,
      required this.source})
      : super(key: key);
  @override
  _MaterialPickingState createState() => _MaterialPickingState();
}

class _MaterialPickingState extends State<MaterialPicking> {
  TextEditingController numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFd2bad6),
        appBar: AppBar(
          backgroundColor: Color(0xFF4c1130),
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.pop(context)),
        ),
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            behavior: HitTestBehavior.opaque,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: 50),
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(
                          '${MyConstant.domain}/uploads/${widget.image}'),
                      fit: BoxFit.contain,
                    ),
                    boxShadow: [
                      BoxShadow(blurRadius: 7.0, color: Colors.white)
                    ]),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  widget.name,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: Center(
                  child: Text(
                    'จำนวนในคลัง : ${(widget.number)}',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, left: 80.0, right: 80.0),
                child: TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'จำนวนที่ต้องการเบิก',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      )),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () => numberCal(),
                  child: Text('ยืนยัน'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF4c1130),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }

  Future numberCal() async {
    String number = numberController.text;
    int input = int.parse(number); //เปลี่ยน string เป็น int
    String id = widget.id;
    int amount = int.parse(widget.number);
    int stockCal = 0;
    if (input <= amount) {
      stockCal = amount - input;
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('จำนวนอุปกรณ์ไม่เพียงพอ'),
              ));
    }
    String path =
        "${MyConstant.domain}/api_nont_demo/amountCal.php?id=$id&number=$stockCal&id2=${widget.source}";
    await Dio().get(path).then((value) {
      if (value.toString() == "true") {
        addHistory();
      }
    });
  }

  Future addHistory() async {
    String history_date = DateTime.now().toString();
    String supply_id = widget.id;
    String supply_name = widget.name;
    String account_id = Global.userid;
    String amount = numberController.text;
    String short_name = Global.his_short_name;
    String path =
        '${MyConstant.domain}/api_nont_demo/addHistory.php?history_date=$history_date&supply_id=$supply_id&money_source_id=${widget.source}&account_id=$account_id&amount=$amount&short_name=$short_name';
    await Dio().get(path).then((value) {
      if (value.toString() == 'true') {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("เบิกอุปกรณ์สำเร็จ"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Tabs(id: Global.userid)),
                            (route) => false),
                        child: Text("ยืนยัน"))
                  ],
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('เกิดข้อผิดพลาดในระบบ\nกรุณาลองใหม่ภายหลัง'),
                ));
      }
    });
  }
}
