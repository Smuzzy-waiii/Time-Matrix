import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_app/screens/Analytics.dart';
import 'package:time_app/screens/Grid.dart';
import 'package:time_app/screens/test.dart';

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
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(centerTitle: true, title: Text("My Time App")),
      body: Stack(
        children: [
          Offstage(
            offstage: currIndex != 0,
            child: Grid(),
          ),
          Offstage(
            offstage: currIndex != 1,
            child: Analytics(),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.black,
        currentIndex: currIndex,
        onTap: (int index) => setState(() {
          currIndex = index;
        }),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics), label: "Analytics")
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/test');
        },
      ),
    );
  }
}
