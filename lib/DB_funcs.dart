import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

Future<bool> rowExists() async {
  Database db = await DatabaseHelper.instance.database;
  var result = await db.rawQuery('SELECT * FROM my_table WHERE date="date"');
  //print(result.isNotEmpty);
  return result.isNotEmpty;
}

Future<List> loadData() async {
  Database db = await DatabaseHelper.instance.database;
  List<Map<String, Object>> result =
      await db.rawQuery('SELECT * FROM my_table WHERE date="date"');
  //print(result);
  List colordata = result[0].values.toList().sublist(1);
  //print(colordata);
  return colordata;
}
