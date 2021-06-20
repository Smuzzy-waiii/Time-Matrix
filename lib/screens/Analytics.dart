import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  DateTime todate;
  DateTime fromdate;
  String todate_str = " ";
  String fromdate_str = " ";
  Widget gap = SizedBox(
    height: 5,
  );

  @override
  void initState() {
    todate = DateFormat('dd-MM-yyyy').parse(DateFormat('dd-MM-yyyy')
        .format(DateTime.now())); //loses time information
    fromdate = todate.subtract(Duration(days: 7));
    todate_str = DateFormat('dd-MM-yyyy').format(todate);
    fromdate_str = DateFormat('dd-MM-yyyy').format(fromdate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: Colors.white, fontSize: 25),
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(5),
            sliver: SliverAppBar(
              floating: true,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: FittedBox(
                fit: BoxFit.contain,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'From Date:',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                      child: Text(
                        fromdate_str,
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () async {
                        final DateTime picked = await showDatePicker(
                            context: context,
                            initialDate: fromdate,
                            firstDate: DateTime(1970, 1, 1),
                            lastDate: DateTime.now());
                        if (picked.isAfter(todate)) {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text("Error!"),
                                    content: Text(
                                        "From-date cannot exceed To-date. Please set to-date first."),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("OK"))
                                    ],
                                  ));
                        } else {
                          setState(() {
                            fromdate = picked;
                            fromdate_str =
                                DateFormat("dd-MM-yyyy").format(fromdate);
                          });
                        }
                      },
                    ),
                    Text(
                      'To Date:',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                      child: Text(
                        todate_str,
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () async {
                        final DateTime picked = await showDatePicker(
                            context: context,
                            initialDate: todate,
                            firstDate: DateTime(1970, 1, 1),
                            lastDate: DateTime.now());
                        if (picked.isBefore(fromdate)) {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text("Error!"),
                                    content: Text(
                                        "To-date cannot preceed From-date. Please set From-date first."),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("OK"))
                                    ],
                                  ));
                        } else {
                          setState(() {
                            todate = picked;
                            todate_str =
                                DateFormat("dd-MM-yyyy").format(todate);
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  gap,
                  Text("Days filled:"),
                  gap,
                  Text("Studied:"),
                  gap,
                  Text("Relaxing:"),
                  gap,
                  Text("Class hours:"),
                  gap,
                  Text("Daily Activites:"),
                  gap,
                  Text("Sleep:"),
                ]),
                Column(
                  children: [
                    gap,
                    Text("0"),
                    gap,
                    Text("0hrs 0mins (0%)"),
                    gap,
                    Text("0hrs 0mins (0%)"),
                    gap,
                    Text("0hrs 0mins (0%)"),
                    gap,
                    Text("0hrs 0mins (0%)"),
                    gap,
                    Text("0hrs 0mins (0%)"),
                  ],
                )
              ]),
              Divider(
                //thickness: 5,
                indent: 18,
                endIndent: 18,
                color: Colors.grey,
              )
            ]),
          )
        ],
      ),
    );
  }
}
