import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:project/Model/historymodel.dart';
import 'package:project/Model/productmodel.dart';
import 'package:project/main.dart';

import 'myConstant.dart';

class History extends StatefulWidget {
  final String id;
  const History({Key? key, required this.id}) : super(key: key);
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<HistoryModel> historyList = [];
  List<String> supplyName = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    String url =
        '${MyConstant.domain}/api_nont_demo/getHistoryWhereId.php?id=${widget.id}';
    await Dio().get(url).then((value) {
      if (value.toString() != "null") {
        for (var item in json.decode(value.data)) {
          historyList.add(HistoryModel.fromMap(item));
          getName(item["supply_id"]);
        }
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {});
        });
      }
    });
  }

  Future getName(String id) async {
    print(id);
    String path =
        '${MyConstant.domain}/api_nont_demo/getSupplyWhereId2.php?id=$id';
    await Dio().get(path).then((value) {
      if (value.toString() != "null") {
        for (var item in json.decode(value.data)) {
          ProductModel model = ProductModel.fromMap(item);
          supplyName.add(model.supply_name);
        }
        print(supplyName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFd2bad6),
      body: Scrollbar(
        child: historyList.isEmpty
            ? const CircularProgressIndicator()
            : ListView(
                padding: EdgeInsets.all(16),
                children: [
                  PaginatedDataTable(
                    rowsPerPage: historyList.length,
                    showCheckboxColumn: false,
                    columns: const [
                      DataColumn(
                        label: Text("No."),
                      ),
                      DataColumn(
                        label: Text("Supply name"),
                      ),
                      DataColumn(
                        label: Text("Amount"),
                      ),
                      DataColumn(
                        label: Text("Short name"),
                      ),
                      DataColumn(
                        label: Text("Date"),
                      ),
                    ],
                    source: _DataSource(context, historyList, supplyName),
                  ),
                ],
              ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final BuildContext context;
  final List<HistoryModel> historyList;
  final List<String> supplyName;
  List<HistoryModel> _rows = List.empty();
  int _selectedCount = 0;

  _DataSource(this.context, this.historyList, this.supplyName) {
    _rows = historyList;
  }

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= historyList.length) return null;
    final row = historyList[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(supplyName[index])),
        DataCell(Text(row.amount)),
        DataCell(Text(row.short_name)),
        DataCell(Text(row.history_date)),
      ],
    );
  }

  @override
  int get rowCount => historyList.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
