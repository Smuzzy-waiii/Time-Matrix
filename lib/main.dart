import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: Home(),
      theme: new ThemeData(
          primaryColor: Colors.orange,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(primary: Colors.blue)))));
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
        appBar: AppBar(
            /*backgroundColor: Colors.yellow[900],*/ title:
                Text("My Time App")),
        body: Grid());
  }
}

class Grid extends StatefulWidget {
  @override
  _GridState createState() => _GridState();
}

int gi_to_li(int i, int j) {
  //Grid indices to List index
  int topPos = j + 1;
  int sidePos = i + 1;
  return 4 * (sidePos - 1) + topPos - 1;
}

class _GridState extends State<Grid> {
  bool fillmode = false;
  Color fillcolor = Colors.red;
  List<Color> colordata = List<Color>.generate(24 * 4, (index) => null);
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
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsetsDirectional.all(5),
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 3,
                  );
                },
                itemCount: 25,
                itemBuilder: (_, i) {
                  return Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                              alignment: Alignment.center,
                              color: Colors.black,
                              padding: EdgeInsets.fromLTRB(0, 1, 1, 0),
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
                              }(), style: TextStyle(color: Colors.white))),
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
                                                BorderRadius.circular(9.0)),
                                        primary:
                                            (colordata[gi_to_li(i, j)] != null)
                                                ? colordata[gi_to_li(i, j)]
                                                : Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        Color currColor =
                                            (colordata[gi_to_li(i, j)] != null)
                                                ? colordata[gi_to_li(i, j)]
                                                : Colors.white;
                                        int pos = colors.indexOf(currColor);
                                        if (fillmode) {
                                          colordata[gi_to_li(i, j)] = fillcolor;
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
                                              style: TextStyle(fontSize: 15),
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
                                        fontSize: 15, color: Colors.white))),
                            if (j < 3) SizedBox(width: 3)
                          ]
                      ]);
                }),
          ),
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
                ElevatedButton(onPressed: () {}, child: Text("Save")),
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
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
