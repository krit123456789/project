import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/Material_picking.dart';
import 'package:project/Model/moneysourcemodel.dart';
import 'package:project/Model/msmodel.dart';
import 'package:project/Model/productmodel.dart';
import 'package:project/myConstant.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SelectMoneysource extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  const SelectMoneysource(
      {Key? key, required this.id, required this.name, required this.image})
      : super(key: key);

  @override
  State<SelectMoneysource> createState() => _SelectMoneysourceState();
}

class _SelectMoneysourceState extends State<SelectMoneysource> {
  List<MoneySourceModel> products = [];
  List<MoneySourceModel> list = [];
  List<String> images = [];
  bool status = true;
  String id = '';
  bool status2 = true;
  String name = '';
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData(widget.id);
  }

  Future getData(String id) async {
    if (products.isNotEmpty) {
      products.clear();
    }
    String path =
        '${MyConstant.domain}/api_nont_demo/getMoneySourceWhereId.php?id=$id';
    await Dio().get(path).then((value) {
      if (value.toString() != "null") {
        for (var item in json.decode(value.data)) {
          MoneySourceModel model = MoneySourceModel.fromMap(item);
          products.add(model);
          getMs(model.money_source_id);
        }
        list = products;
        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            status = false;
          });
        });
      }
    });
  }

  Future getMs(String id) async {
    String path =
        '${MyConstant.domain}/api_nont_demo/getNameImageWhereId.php?id=$id';
    await Dio().get(path).then((value) {
      if (value.toString() != "null") {
        for (var item in json.decode(value.data)) {
          images.add(item['source_picture']);
        }
        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            status2 = false;
          });
        });
      }
    });
  }

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
      // body: Items(),
      body: status && status2
          ? CircularProgressIndicator()
          : Column(
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 20.sp,
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 240, childAspectRatio: 2 / 3),
                    itemBuilder: (context, index) =>
                        Items(context, products[index], index),
                  ),
                ),
              ],
            ),
    );
  }

  /* DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
          "${item} ${indexsource == sources.length - 1 ? '' : sources[indexsource++]}"),
    );
  }*/

  Widget Items(BuildContext context, MoneySourceModel product, int index) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MaterialPicking(
                    id: product.supply_id,
                    name: widget.name,
                    image: widget.image,
                    number: product.amount,
                    source: product.money_source_id,
                  ))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: const EdgeInsets.all(8.0)),
          Container(
            height: 160,
            width: 140,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 2.0,
                  color: const Color(0xFF000000),
                )),
            child: Image(
              image:
                  NetworkImage("${MyConstant.domain}uploads/${widget.image}"),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 140,
            child: Text(
              "ชื่อวัสดุ : ${widget.name}",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            "จำนวนในคลัง : ${product.amount}",
          ),
          Text(
            "แหล่งเงิน",
          ),
          images.isEmpty
              ? Container()
              : Container(
                  width: 30,
                  height: 30,
                  child: Image(
                    image: NetworkImage(
                        "${MyConstant.domain}uploads/${images[index]}"),
                    fit: BoxFit.cover,
                  ),
                ),
        ],
      ),
    );
  }
}
