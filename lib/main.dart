import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:time_app/DB_funcs.dart';
import 'package:time_app/database_helper.dart';
import 'package:time_app/test.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'help_functions.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/',
      routes: {'/': (context) => Home(), '/test': (context) => Test()},
      theme: new ThemeData(
        primaryColor: Colors.orange,
        //elevatedButtonTheme: ElevatedButtonThemeData(
        //style: ElevatedButton.styleFrom(primary: Colors.blue)))));
      )));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(centerTitle: true, title: Text("My Time App")),
      body: Grid(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics), label: "Analytics")
        ],
      ),
    );
  }
}

void save(List buttondata, String date, Map color_names) async {
  Database db = await DatabaseHelper.instance.database;
  if (await rowExists(date) == false) {
    await db.rawInsert("INSERT INTO my_table VALUES(${bindings()})",
        <dynamic>[date] + buttondata.map((e) => color_names[e]).toList());
  } else {
    await db.rawDelete("Delete from my_table where date = ?", ['date']);

    await db.rawInsert("INSERT INTO my_table VALUES(${bindings()})",
        <dynamic>['date'] + buttondata.map((e) => color_names[e]).toList());
  }
}

class Grid extends StatefulWidget {
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  bool fillmode = false;
  Color fillcolor = Colors.red;
  //List colordata = ;
  List<Color> colors = [
    Colors.white,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.yellow,
    Colors.white
  ];

  Map color_names = {
    Colors.white: 'white',
    Colors.red: 'Red',
    Colors.green: 'Green',
    Colors.blue: 'Blue',
    Colors.orange: 'Orange',
    Colors.yellow: 'Yellow',
  };
  Map rev_color_names;
  List<Color> colordata;
  String date = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  void initState() {
    rev_color_names = color_names.map((k, v) => MapEntry(v, k));
    loadColorData(date, rev_color_names).then((value) {
      setState(() {
        colordata = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
              padding: EdgeInsetsDirectional.all(5),
              child: colordata == null
                  ? SpinKitFadingCircle(
                      color: Colors.white,
                    )
                  : CustomScrollView(slivers: <Widget>[
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                        sliver: SliverAppBar(
                            floating: true,
                            centerTitle: true,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    icon: Icon(Icons.keyboard_arrow_left),
                                    //iconSize: 10
                                    onPressed: () {
                                      setState(() {
                                        colordata = null;
                                      });

                                      DateTime _date =
                                          DateFormat("dd-MM-yyyy").parse(date);
                                      _date = _date.subtract(Duration(days: 1));

                                      setState(() {
                                        date = DateFormat("dd-MM-yyyy")
                                            .format(_date);
                                      });
                                      loadColorData(date, rev_color_names)
                                          .then((value) {
                                        setState(() {
                                          colordata = value;
                                        });
                                      });
                                    }),
                                FittedBox(
                                    fit: BoxFit.contain,
                                    child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          date,
                                          style: TextStyle(
                                            fontSize: 19,
                                          ),
                                        ))),
                                IconButton(
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onPressed: () {
                                    setState(() {
                                      colordata = null;
                                    });

                                    DateTime _date =
                                        DateFormat("dd-MM-yyyy").parse(date);
                                    _date = _date.add(Duration(days: 1));

                                    setState(() {
                                      date = DateFormat("dd-MM-yyyy")
                                          .format(_date);
                                    });
                                    loadColorData(date, rev_color_names)
                                        .then((value) {
                                      setState(() {
                                        colordata = value;
                                      });
                                    });
                                  },
                                )
                              ],
                            ),
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int i) {
                          if (i % 2 != 0) {
                            return SizedBox(height: 3);
                          } else {
                            i = i ~/ 2;
                            return Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                        alignment: Alignment.center,
                                        color: Colors.black,
                                        padding:
                                            EdgeInsets.fromLTRB(0, 1, 1, 0),
                                        child: Text(() {
                                          i -= 1;
                                          if (i == -1) {
                                            return "Time";
                                          } else if (i == 0) {
                                            return "12:00AM";
                                          } else if (i < 12 && i > 0) {
                                            return "${(i) < 10 ? '0${i}:00AM' : '${i}:00AM'}";
                                          } else if (i == 12) {
                                            return "12:00PM";
                                          } else if (i > 12 && i < 24) {
                                            return "${(i - 12) < 10 ? '0${i - 12}:00PM' : '${i - 12}:00PM'}";
                                          }
                                        }(),
                                            style: TextStyle(
                                                color: Colors.white))),
                                  ),
                                  if (i != -1)
                                    for (int j = 0; j < 4; j++) ...[
                                      Expanded(
                                        child: AspectRatio(
                                          aspectRatio: 1.5,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9.0)),
                                                  primary: (colordata[
                                                              gi_to_li(i, j)] !=
                                                          null)
                                                      ? colordata[
                                                          gi_to_li(i, j)]
                                                      : Colors.white),
                                              onPressed: () {
                                                setState(() {
                                                  Color currColor = (colordata[
                                                              gi_to_li(i, j)] !=
                                                          null)
                                                      ? colordata[
                                                          gi_to_li(i, j)]
                                                      : Colors.white;
                                                  int pos =
                                                      colors.indexOf(currColor);
                                                  if (fillmode) {
                                                    colordata[gi_to_li(i, j)] =
                                                        fillcolor;
                                                  } else {
                                                    colordata[gi_to_li(i, j)] =
                                                        colors[pos + 1];
                                                  }
                                                });
                                              },
                                              /*color: (colordata[gi_to_li(i, j)] != null)
                                          ? colordata[gi_to_li(i, j)]
                                          : Colors.white,*/
                                              child: i != -1
                                                  ? Container()
                                                  : FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        () {
                                                          return "${15 * j}-${15 * (j + 1)}";
                                                        }(),
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ))),
                                        ),
                                      ),
                                      if (j < 3) SizedBox(width: 3)
                                    ],
                                  if (i == -1)
                                    for (int j = 0; j < 4; j++) ...[
                                      Expanded(
                                          child: Text(
                                              "${(j == 0) ? '0${15 * j}-${15 * (j + 1)}' : '${15 * j}-${15 * (j + 1)}'}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white))),
                                      if (j < 3) SizedBox(width: 3)
                                    ]
                                ]);
                          }
                        },
                        childCount: 25 * 2,
                      )),
                    ])),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: ElevatedButton(
                    child: Text("Clear all"),
                    onPressed: () {
                      setState(() {
                        colordata = List.generate(24 * 4, (index) => null);
                      });
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      save(colordata, date, color_names);
                    },
                    child: Text("Save")),
                Text(
                  "Fill Mode:",
                  style: TextStyle(color: Colors.white),
                ),
                ElevatedButton(
                  child: Text("${fillmode ? 'ON' : 'OFF'}"),
                  onPressed: () {
                    setState(() {
                      fillmode = !fillmode;
                    });
                  },
                ),
                if (fillmode)
                  Text(
                    "Fill Color:",
                    style: TextStyle(color: Colors.white),
                  ),
                ElevatedButton(
                  child: Text(
                    "${color_names[fillcolor]}",
                    style: TextStyle(color: () {
                      if (fillmode) {
                        return fillcolor.computeLuminance() > 0.5
                            ? Colors.black
                            : Colors.white;
                      } else {
                        return Colors.black;
                      }
                    }()),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: fillcolor,
                  ),
                  onPressed: !fillmode
                      ? null
                      : () {
                          setState(() {
                            int index = colors.indexOf(fillcolor);
                            fillcolor = colors[index + 1];
                          });
                        },
                ),
                ElevatedButton(
                  child: Text("Print"),
                  onPressed: () {
                    //Navigator.pushNamed(context, '/test');
                    print(date);
                  },
                ),
                ElevatedButton(
                  child: Text("Test"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/test');
                  },
                ),
                ElevatedButton(
                  child: Text("Refresh"),
                  onPressed: () {
                    setState(() {
                      colordata = null;
                    });
                    loadColorData(date, rev_color_names).then((value) {
                      setState(() {
                        colordata = value;
                      });
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
