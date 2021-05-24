import 'package:flutter/material.dart';

import 'DB_funcs.dart';

int gi_to_li(int i, int j) {
  //Grid indices to List index
  int topPos = j + 1;
  int sidePos = i + 1;
  return 4 * (sidePos - 1) + topPos - 1;
}

String bindings() {
  String s = '';
  for (var i = 0; i < 97; i++) {
    s += (i != 96) ? '?,' : '?';
  }
  return s;
}

Future<List<Color>> loadColorData(Map rev_color_names) async {
  bool _rowExists = (await rowExists()) == true;
  List _colordata = _rowExists
      ? (await loadData()).map((e) => rev_color_names[e]).toList().cast<Color>()
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
