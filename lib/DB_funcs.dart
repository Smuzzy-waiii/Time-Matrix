import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

Future<int> createView() async {
  Database db = await DatabaseHelper.instance.database;
  var batch = db.batch()
    ..execute('DROP VIEW IF EXISTS my_view')
    ..execute('CREATE VIEW my_view AS SELECT * from my_table');
  await batch.commit();
  return 1;
}

Future<Database> initDB() async {
  Database db = await DatabaseHelper.instance.database;
  return db;
}

Future<bool> rowExists(Database db, String date) async {
  //Database db = await DatabaseHelper.instance.database;
  var result = await db.rawQuery('SELECT * FROM my_view WHERE date="$date"');
  //print(result.isNotEmpty);
  return result.isNotEmpty;
}

Future<List> loadData(Database db, String date) async {
  //Database db = await DatabaseHelper.instance.database;
  List<Map<String, Object>> result =
      await db.rawQuery('SELECT * FROM my_view WHERE date="$date"');
  //print(result);
  List colordata = result[0].values.toList().sublist(1);
  //print(colordata);
  return colordata;
}
