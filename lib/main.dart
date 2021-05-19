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
    return Scaffold(appBar: AppBar(title: Text("My Time App")), body: Time());
  }
}

class Time extends StatefulWidget {
  @override
  _TimeState createState() => _TimeState();
}

List<Widget> generateButtonList() {
  List<Widget> button_list = [];
  for (var i = 0; i < 24 * 4; i++) {
    button_list.add(RaisedButton(
      color: Colors.grey,
      child: Text(i.toString()),
      onPressed: () {},
    ));
  }
  print(button_list);
  return button_list;
}

class _TimeState extends State<Time> {
  List<Widget> button_list = generateButtonList();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 5,
      childAspectRatio: 1,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      children: button_list,
    );
  }
}
