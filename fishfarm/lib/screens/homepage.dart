// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   Future<void> _signOut() async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.pushNamed(context, '/');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.exit_to_app),
//             onPressed: () {
//               _signOut();
//             },
//           ),
//         ],
//       ),
//       body: const Center(
//         child: Text('Welcome to Firebase'),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;

  @override
  void initState() {
    chartData = getChartData();
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Data Visualization'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    const Text(
                      'Turbudity',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    Card(
                      elevation: 3,
                      // height: MediaQuery.of(context).size.height * 0.4,
                      child: SfCartesianChart(
                          series: <LineSeries<LiveData, int>>[
                            LineSeries<LiveData, int>(
                              onRendererCreated:
                                  (ChartSeriesController controller) {
                                _chartSeriesController = controller;
                              },
                              dataSource: chartData,
                              color: const Color.fromRGBO(192, 108, 132, 1),
                              xValueMapper: (LiveData sales, _) => sales.time,
                              yValueMapper: (LiveData sales, _) => sales.speed,
                            )
                          ],
                          primaryXAxis: NumericAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              interval: 3,
                              title: AxisTitle(text: 'Time (seconds)')),
                          primaryYAxis: NumericAxis(
                              axisLine: const AxisLine(width: 0),
                              majorTickLines: const MajorTickLines(size: 0),
                              title: AxisTitle(text: 'Turbudity (m/s)'))),
                    ),
                    const Text(
                      'Temperature',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    Card(
                      elevation: 3,
                      // height: MediaQuery.of(context).size.height * 0.4,
                      child: SfCartesianChart(
                          series: <LineSeries<LiveData, int>>[
                            LineSeries<LiveData, int>(
                              onRendererCreated:
                                  (ChartSeriesController controller) {
                                _chartSeriesController = controller;
                              },
                              dataSource: chartData,
                              color: const Color.fromRGBO(192, 108, 132, 1),
                              xValueMapper: (LiveData sales, _) => sales.time,
                              yValueMapper: (LiveData sales, _) => sales.speed,
                            )
                          ],
                          primaryXAxis: NumericAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              interval: 3,
                              title: AxisTitle(text: 'Time (seconds)')),
                          primaryYAxis: NumericAxis(
                              axisLine: const AxisLine(width: 0),
                              majorTickLines: const MajorTickLines(size: 0),
                              title: AxisTitle(text: 'Temperature (°C)'))),
                    ),
                    const Text(
                      'PH',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    Card(
                      elevation: 3,
                      // height: MediaQuery.of(context).size.height * 0.4,
                      child: SfCartesianChart(
                          series: <LineSeries<LiveData, int>>[
                            LineSeries<LiveData, int>(
                              onRendererCreated:
                                  (ChartSeriesController controller) {
                                _chartSeriesController = controller;
                              },
                              dataSource: chartData,
                              color: const Color.fromRGBO(192, 108, 132, 1),
                              xValueMapper: (LiveData sales, _) => sales.time,
                              yValueMapper: (LiveData sales, _) => sales.speed,
                            )
                          ],
                          primaryXAxis: NumericAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              interval: 3,
                              title: AxisTitle(text: 'Time (seconds)')),
                          primaryYAxis: NumericAxis(
                              axisLine: const AxisLine(width: 0),
                              majorTickLines: const MajorTickLines(size: 0),
                              title: AxisTitle(text: 'PH'))),
                    ),
                  ],
                ),
              ),
            )));
  }

  int time = 19;
  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 42),
      LiveData(1, 47),
      LiveData(2, 43),
      LiveData(3, 49),
      LiveData(4, 54),
      LiveData(5, 41),
      LiveData(6, 58),
      LiveData(7, 51),
      LiveData(8, 98),
      LiveData(9, 41),
      LiveData(10, 53),
      LiveData(11, 72),
      LiveData(12, 86),
      LiveData(13, 52),
      LiveData(14, 94),
      LiveData(15, 92),
      LiveData(16, 86),
      LiveData(17, 72),
      LiveData(18, 94)
    ];
  }
}

class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final num speed;
}
