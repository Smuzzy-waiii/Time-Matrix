import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    //theme: new ThemeData(scaffoldBackgroundColor: Colors.black),
  ));
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
            backgroundColor: Colors.yellow[900], title: Text("My Time App")),
        body: Grid());
  }
}

class Grid extends StatefulWidget {
  @override
  _GridState createState() => _GridState();
}

int gi_to_li(int i, int j) {
  //Grid indices to List index
  int top_pos = j + 1;
  int side_pos = i + 1;
  return 4 * (side_pos - 1) + top_pos;
}

class _GridState extends State<Grid> {
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
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    onPressed: () {
                                      setState(() {
                                        print("${i + 1}, ${j + 1}");
                                        Color curr_color =
                                            (colordata[gi_to_li(i, j)] != null)
                                                ? colordata[gi_to_li(i, j)]
                                                : Colors.white;
                                        int pos = colors.indexOf(curr_color);
                                        colordata[gi_to_li(i, j)] =
                                            colors[pos + 1];
                                      });
                                    },
                                    color: (colordata[gi_to_li(i, j)] != null)
                                        ? colordata[gi_to_li(i, j)]
                                        : Colors.white,
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
        Spacer(),
      ],
    );
  }
}
