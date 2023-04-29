import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:time_app/screens/Analytics.dart';
import 'package:time_app/screens/Grid.dart';
import 'package:time_app/screens/test.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/',
      routes: {'/': (context) => Home(), '/test': (context) => Test()},
      theme: new ThemeData(
        primaryColor: Colors.blue[600],
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
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Time App"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        backgroundColor: Colors.purple[100],
                        title: Text("Info"),
                        content: RichText(
                            text: TextSpan(
                                style: GoogleFonts.dosis(
                                    textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                )),
                                children: <TextSpan>[
                              TextSpan(
                                  text:
                                      "Your day has been divided into 15min slots.\nLegend-\n"),
                              TextSpan(
                                  text: "Green: Studied\n",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "Red: Relaxing\n",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "Blue: Class hrs\n",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "Orange: Daily Activities\n",
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "Yellow: Sleep\n\n",
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "Pull down to refresh Analytics page.")
                            ])),
                        actions: [
                          TextButton(
                            child: Text(
                              "Got it!",
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          )
                        ],
                      ));
            },
            icon: Icon(Icons.info_outline),
            iconSize: 27,
          )
        ],
      ),
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
        backgroundColor: Colors.blue[600],
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
