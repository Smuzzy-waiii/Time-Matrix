import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("My Time App")), body: Grid());
  }
}

List<Widget> generateGridColumns() {
  List<Widget> buttonrows = [];
  for (var i = 0; i < 24; i++) {
    buttonrows.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          child: Text("${(i + 1) < 10 ? '0${i + 1}:00' : '${i + 1}:00'}"),
        ),
        RaisedButton(
          onPressed: () {},
          //child: Text("${i + 1}:00-${i + 1}:15"),
        ),
        RaisedButton(
          onPressed: () {},
          //child: Text("${i + 1}:15-${i + 1}:30"),
        ),
        RaisedButton(
          onPressed: () {},
          //child: Text("${i + 1}:30-${i + 1}:45"),
        ),
        RaisedButton(
          onPressed: () {},
          //child: Text("${i + 1}:45-${i + 2}:00"),
        )
      ],
    ));
  }
  return buttonrows;
}

class Grid extends StatefulWidget {
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: generateGridColumns(),
    );
  }
}
