import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Time(),
  ));
}

class Time extends StatefulWidget {
  @override
  _TimeState createState() => _TimeState();
}

List<List<Widget>> generateButtonList() {
  List<List<Widget>> button_list = [];
  for (var i = 0; i < 24; i++) {
    button_list.add(<Widget>[]);
    for (var j = 0; j < 4; j++) {
      button_list[i].add(RaisedButton(
        color: Colors.grey,
        onPressed: () {},
      ));
    }
  }
  print(button_list);
  return button_list;
}

List<Widget> generateRowList(List<List<Widget>> button_list) {
  List<Widget> row_list = [];
  for (var day in button_list) {
    row_list.add(Row(
      children: day,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    ));
  }
  return row_list;
}

class _TimeState extends State<Time> {
  List<List<Widget>> button_list = generateButtonList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Time App"),
        ),
        body: Column(
          children: generateRowList(button_list),
          mainAxisSize: MainAxisSize.min,
        ));
  }
}
