import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:time_app/helpers/database_helper.dart';

import 'DB_funcs.dart';

int gi_to_li(int i, int j) {
  //Grid indices to List index
  int topPos = j + 1;
  int sidePos = i + 1;
  return 4 * (sidePos - 1) + topPos - 1;
}

void saveOne(Database db, int i, int j, String date, String color) async {
  if (await rowExists(db, date) == false) {
    await db.rawInsert(
        "INSERT INTO my_table (date, ${genColumnName(gi_to_li(i, j))}) VALUES (?, ?)",
        [date, color]);
  } else {
    await db.rawUpdate(
        "UPDATE my_table SET ${genColumnName(gi_to_li(i, j))}=? WHERE date=?",
        [color, date]);
  }
}

String genColumnName(int i) {
  int _hr = (i ~/ 4);
  String hr = _hr < 10 ? "0$_hr" : "$_hr";
  int _mins = ((i % 4) * 15);
  String mins = _mins < 10 ? "0$_mins" : "$_mins";
  int _minsPlusOne =
      i % 4 != 3 ? (((i % 4) + 1) * 15) : 0; //  ~/ is integer division
  String minsPlusOne = _minsPlusOne < 10 ? "0$_minsPlusOne" : "$_minsPlusOne";
  String column_name = "'$hr:$mins-$hr:$minsPlusOne'";
  return column_name;
}

//creates the sequence ?,?,?,?,... for queries
String bindings() {
  String s = '';
  for (var i = 0; i < 97; i++) {
    s += (i != 96) ? '?,' : '?';
  }
  return s;
}

Future<Map> getColorCounts(String fromdate, String todate,
    {bool for_graph: false}) async {
  Map counts = {
    "days": 0,
    "studied": 0,
    "relaxing": 0,
    "class": 0,
    "DA": 0,
    "sleep": 0,
    "unfilled": 0,
    "total": 0
  };

  Database db = await DatabaseHelper.instance.database;
  List range = await getRange(db, fromdate, todate);

  for (List row in range) {
    counts["days"] += 1;
    for (var color in row.sublist(1)) {
      counts["total"] += 1;
      switch (color) {
        case "Red":
          counts["relaxing"] += 1;
          break;
        case "Green":
          counts["studied"] += 1;
          break;
        case "Blue":
          counts["class"] += 1;
          break;
        case "Orange":
          counts["DA"] += 1;
          break;
        case "Yellow":
          counts["sleep"] += 1;
          break;
        default:
          counts["unfilled"] += 1;
      }
    }
  }
  print(counts);
  return counts;
}

String invDF(String date) {
  //convert yyyy-mm-dd into dd-mm-yyyy
  String yr, mn, dt;
  yr = date.substring(0, 4);
  mn = date.substring(5, 7);
  dt = date.substring(8);
  return "$dt-$mn-$yr";
}

Map<String, double> forGraph(Map counts) {
  Map<String, double> newMap = {};

  for (String key in counts.keys) {
    if (key != 'total' && key != 'days') {
      int item = counts[key];
      newMap[key] = item.toDouble();
    }
  }
  return newMap;
}

String counts_to_str(int counts, int total) {
  int tot_mins = counts * 15;
  int hrs = tot_mins ~/ 60;
  int mins = tot_mins % 60;
  double raw_pctage = ((counts / total) * 100);
  String pctage = raw_pctage.isNaN ? "0" : raw_pctage.toStringAsFixed(2);
  return "${hrs}hrs ${mins}mins (${pctage}%)";
}

Future<List<Color>> loadColorData(
    Database db, String date, Map rev_color_names) async {
  await createView();

  bool _rowExists = (await rowExists(db, date)) == true;
  List _colordata = _rowExists
      ? (await loadData(db, date))
          .map((e) => rev_color_names[e])
          .toList()
          .cast<Color>()
      : List<Color>.generate(24 * 4, (index) => null);
  return _colordata;
}

Map invertMap(Map map) {
  return map.map((k, v) => MapEntry(v, k));
}

String genColumnNames() {
  String columns = '';
  for (var i = 0; i < 24 * 4; i++) {
    int _hr = (i ~/ 4);
    String hr = _hr < 10 ? "0$_hr" : "$_hr";
    int _mins = ((i % 4) * 15);
    String mins = _mins < 10 ? "0$_mins" : "$_mins";
    int _minsPlusOne =
        i % 4 != 3 ? (((i % 4) + 1) * 15) : 0; //  ~/ is integer division
    String minsPlusOne = _minsPlusOne < 10 ? "0$_minsPlusOne" : "$_minsPlusOne";
    String column_name = "'$hr:$mins-$hr:$minsPlusOne'";
    //print(column_name);

    columns += (i != 24 * 4 - 1) ? "$column_name TEXT,\n" : "$column_name TEXT";
  }
  //print(columns);
  return columns;
}
