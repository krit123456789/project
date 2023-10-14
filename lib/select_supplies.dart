import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/Material_picking.dart';
import 'package:project/Model/productmodel.dart';
import 'package:project/myConstant.dart';
import 'package:project/select_moneysource.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SelectSupplies extends StatefulWidget {
  final String id;
  const SelectSupplies({Key? key, required this.id}) : super(key: key);

  @override
  State<SelectSupplies> createState() => _SelectSuppliesState();
}

class _SelectSuppliesState extends State<SelectSupplies> {
  List<ProductModel> products = [];
  List<ProductModel> list = [];
  List<String> amounts = [];
  bool status = true;
  String id = '';
  bool status2 = true;
  String name = '';
  String amount = '';
  bool status3 = true;
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData(widget.id);
    getName(widget.id);

    print(widget.id);
  }

  void searchSupply(String value) {
    list = products.where((element) {
      final title = element.supply_name.toLowerCase();
      final search = value.toLowerCase();
      return title.contains(search);
    }).toList();
    setState(() {});
  }

  Future getData(String id) async {
    if (products.isNotEmpty) {
      products.clear();
    }
    String path =
        '${MyConstant.domain}/api_nont_demo/getSupplyWhereCategory.php?id=$id';
    await Dio().get(path).then((value) {
      if (value.toString() != "null") {
        for (var item in json.decode(value.data)) {
          ProductModel model = ProductModel.fromMap(item);
          products.add(model);
          getAmount(model.supply_id);
        }
        list = products;
        setState(() {
          status = false;
        });
      }
    });
  }

  Future getName(String id) async {
    String path =
        '${MyConstant.domain}/api_nont_demo/getCategoryWhereId.php?id=$id';
    await Dio().get(path).then((value) {
      if (value.toString() != "null") {
        for (var item in json.decode(value.data)) {
          name = item['category_name'];
        }
        setState(() {
          status2 = false;
        });
      }
    });
  }

  Future getAmount(String id) async {
    String path =
        '${MyConstant.domain}/api_nont_demo/getAmountWhereId.php?id=$id';
    await Dio().get(path).then((value) {
      if (value.toString() != "null") {
        print(value.data);
        for (var item in json.decode(value.data)) {
          amounts.add(item['amount']);
        }
        setState(() {
          status3 = false;
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
      body: status && status2 && status3
          ? CircularProgressIndicator()
          : Column(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20.sp,
                  ),
                ),
                /*Container(
                  width: 40.w,
                  child: DropdownButton(
                    isExpanded: true,
                    value: type,
                    items: types.map(buildMenuItem).toList(),
                    onChanged: (value) {
                      setState(() {
                        indexsource = 0;
                        type = value as String;
                      });
                      getName(value as String);
                    },
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: TextFormField(
                      controller: search,
                      onChanged: (value) => searchSupply(value),
                      decoration: InputDecoration(
                        hintText: "ค้นหา",
                        prefixIcon: Icon(Icons.search),
                      )),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: list.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 240, childAspectRatio: 4 / 5),
                    itemBuilder: (context, index) =>
                        Items(context, list[index], index),
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

  Widget Items(BuildContext context, ProductModel product, int index) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectMoneysource(
                  id: product.supply_id,
                  name: product.supply_name,
                  image: product.supply_picture))),
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
              image: NetworkImage(
                  "${MyConstant.domain}uploads/${product.supply_picture}"),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 140,
            child: Text(
              "${product.supply_name}",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          amounts.isEmpty
              ? Container()
              : Text(
                  "จำนวนในคลัง : ${amounts[index] == null ? 'ไม่มี' : amounts[index]}",
                )
        ],
      ),
    );
  }
}
