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
        appBar:
            AppBar(backgroundColor: Colors.green, title: Text("My Time App")),
        body: Grid());
  }
}

class Grid extends StatefulWidget {
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
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
                itemCount: 24,
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
                            child: Text(
                                "${(i) < 10 ? '0${i}:00' : '${i + 1}:00'} AM",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        for (i = 0; i < 4; i++) ...[
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1.5,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                onPressed: () {},
                                color: Colors.white,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "00-15",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (i < 3) SizedBox(width: 3)
                        ],
                      ]);
                }),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
