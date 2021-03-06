import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:time_app/helpers/DB_funcs.dart';
import 'package:time_app/helpers/help_functions.dart';
import 'package:collection/collection.dart';
import '../helpers/database_helper.dart';

Function eq = const ListEquality().equals;

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

delete_all() async {
  DatabaseHelper helper = await DatabaseHelper.instance;
  Database db = await helper.database;
  await db.delete("my_table");
  List<Map> result = await db.rawQuery("PRAGMA table_info([my_table]);");
  print(result);
}

_query() async {
  // get a reference to the database
  DatabaseHelper helper = await DatabaseHelper.instance;
  Database db = await helper.database;

  //await db.delete("my_table");
  // raw query
  //List<Map> result = await db.rawQuery("PRAGMA table_info([my_table]);");
  List<Map> result = await db.rawQuery("SELECT * FROM my_table");

  // print the results
  result.forEach((row) => print(row.values));
  // {_id: 2, name: Mary, age: 32}
}

class _TestState extends State<Test> {
  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('Read'),
              onPressed: () async {},
            ),
            ElevatedButton(
              child: Text("Read All"),
              onPressed: () async {
                _query();
              },
            ),
            ElevatedButton(
              child: Text("Delete all"),
              onPressed: () {
                delete_all();
              },
            ),
            ElevatedButton(
              child: Text("Test"),
              onPressed: () {
                print(invDF("2012-12-13"));
              },
            ),
          ],
        ),
      ),
    );
  }
}
