import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_app/helpers/help_functions.dart';
import 'package:pie_chart/pie_chart.dart';

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
  Map counts;
  int total;

  @override
  void initState() {
    todate = DateFormat('yyyy-MM-dd').parse(DateFormat('yyyy-MM-dd')
        .format(DateTime.now())); //loses time information
    fromdate = todate.subtract(Duration(days: 7));
    todate_str = DateFormat('yyyy-MM-dd').format(todate);
    fromdate_str = DateFormat('yyyy-MM-dd').format(fromdate);

    getColorCounts(fromdate_str, todate_str).then((value) => setState(() {
          counts = value;
          total = counts["total"];
        }));
    super.initState();
  }

  Map color_names = {
    Colors.green: 'Green',
    Colors.red: 'Red',
    Colors.blue: 'Blue',
    Colors.orange: 'Orange',
    Colors.yellow: 'Yellow',
    Colors.grey[400]: 'white',
  };

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Map value = await getColorCounts(fromdate_str, todate_str);
        setState(() {
          counts = value;
          total = counts["total"];
        });
      },
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.white, fontSize: 20),
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
                          invDF(fromdate_str),
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
                                  DateFormat("yyyy-MM-dd").format(fromdate);
                            });
                            Map value =
                                await getColorCounts(fromdate_str, todate_str);
                            setState(() {
                              counts = value;
                              total = counts["total"];
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
                          invDF(todate_str),
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
                                  DateFormat("yyyy-MM-dd").format(todate);
                            });
                            Map value =
                                await getColorCounts(fromdate_str, todate_str);
                            setState(() {
                              counts = value;
                              total = counts["total"];
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            gap,
                            Text("Unfilled:"),
                          ]),
                      Column(
                        children: [
                          gap,
                          counts == null
                              ? Text('loading...')
                              : Text(counts['days'].toString()),
                          gap,
                          counts == null
                              ? Text('loading...')
                              : Text(counts_to_str(counts["studied"], total)),
                          gap,
                          counts == null
                              ? Text('loading...')
                              : Text(counts_to_str(counts["relaxing"], total)),
                          gap,
                          counts == null
                              ? Text('loading...')
                              : Text(counts_to_str(counts["class"], total)),
                          gap,
                          counts == null
                              ? Text('loading...')
                              : Text(counts_to_str(counts["DA"], total)),
                          gap,
                          counts == null
                              ? Text('loading...')
                              : Text(counts_to_str(counts["sleep"], total)),
                          gap,
                          counts == null
                              ? Text('loading...')
                              : Text(counts_to_str(counts["unfilled"], total)),
                        ],
                      )
                    ]),
                Divider(
                  //thickness: 5,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.grey,
                ),
                if (counts != null && counts['total'] != 0)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: PieChart(
                      dataMap: forGraph(counts),
                      colorList: color_names.keys.toList().cast<Color>(),
                      chartRadius: MediaQuery.of(context).size.width / 1.5,
                      initialAngleInDegree: -90,
                      legendOptions: LegendOptions(
                        showLegendsInRow: true,
                        legendPosition: LegendPosition.bottom,
                        showLegends: true,
                      ),
                      chartValuesOptions: ChartValuesOptions(
                        showChartValueBackground: true,
                        showChartValues: true,
                        showChartValuesInPercentage: true,
                        showChartValuesOutside: true,
                        decimalPlaces: 1,
                      ),
                    ),
                  ),
                //New Widgets Come here
              ]),
            )
          ],
        ),
      ),
    );
  }
}
