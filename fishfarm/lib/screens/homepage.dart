import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<String> getJsonFromFirebaseRestAPI() async {
    String url = "https://fishfarm-d5334-default-rtdb.firebaseio.com/Data.json";
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }

  List<ChartData> chartData = [];

  Future loadChartData() async {
    String jsonString = await getJsonFromFirebaseRestAPI();

    final jsonResponse = json.decode(jsonString);

    setState(() {
      chartData.add(ChartData.fromJson(jsonResponse));
    });
  }

  @override
  void initState() {
    loadChartData();
    super.initState();
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Navigator.pushNamed(context, '/'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Data Visualization'),
          actions: [
            IconButton(
                onPressed: () {
                  _signOut();
                },
                icon: const Icon(Icons.logout_rounded))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                child: FutureBuilder(
                    future: getJsonFromFirebaseRestAPI(),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        return SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            title: ChartTitle(text: 'Turbidity changes'),
                            series: <ChartSeries<ChartData, String>>[
                              LineSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.time,
                                yValueMapper: (ChartData data, _) =>
                                    data.turbidity,
                              )
                            ]);
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ),
              FutureBuilder(
                  future: getJsonFromFirebaseRestAPI(),
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      return Card(
                        child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            title: ChartTitle(text: 'PH changes'),
                            series: <ChartSeries<ChartData, String>>[
                              LineSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.time,
                                yValueMapper: (ChartData data, _) =>
                                    data.turbidity,
                              )
                            ]),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.time, this.turbidity);

  final String time;
  final num turbidity;

  factory ChartData.fromJson(Map<String, dynamic> parsedJson) {
    return ChartData(
      parsedJson['time'].toString(),
      parsedJson['turbidity'],
    );
  }
}
