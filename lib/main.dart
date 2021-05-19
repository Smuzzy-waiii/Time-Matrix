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
  int buttonsize = 40;

  for (var i = 0; i < 24; i++) {
    buttonrows.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Text("${(i + 1) < 10 ? '0${i + 1}:00' : '${i + 1}:00'}"),
        ),
        Container(
          height: 30,
          child: AspectRatio(
            aspectRatio: 1,
            child: RaisedButton(
              onPressed: () {},
              //child: Text("${i + 1}:00-${i + 1}:15"),
            ),
          ),
        ),
        Container(
          height: 30,
          child: AspectRatio(
            aspectRatio: 1,
            child: RaisedButton(
              onPressed: () {},
              //child: Text("${i + 1}:00-${i + 1}:15"),
            ),
          ),
        ),
        Container(
          height: 30,
          child: AspectRatio(
            aspectRatio: 1,
            child: RaisedButton(
              onPressed: () {},
              //child: Text("${i + 1}:00-${i + 1}:15"),
            ),
          ),
        ),
        Container(
          height: 30,
          child: AspectRatio(
            aspectRatio: 1,
            child: RaisedButton(
              onPressed: () {},
              //child: Text("${i + 1}:00-${i + 1}:15"),
            ),
          ),
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
    return Container(
      padding: EdgeInsetsDirectional.all(5),
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 5,
            );
          },
          itemCount: 24,
          itemBuilder: (_, i) {
            return Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    color: Colors.grey[350],
                    padding: EdgeInsets.fromLTRB(0, 35, 5, 35),
                    child: Text(
                        "${(i + 1) < 10 ? '0${i + 1}:00' : '${i + 1}:00'}"),
                  ),
                  for (i = 0; i < 4; i++) ...[
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: RaisedButton(
                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                          onPressed: () {},
                          //child: Text("${i + 1}:00-${i + 1}:15"),
                        ),
                      ),
                    ),
                    SizedBox(width: 5)
                  ],
                ]);
          }),
    );
  }
}
