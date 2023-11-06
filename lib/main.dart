import 'package:flutter/material.dart';
import 'package:flutter_highchart/linechart_screen.dart';
import 'package:flutter_highchart/piechart_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'HighChart Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(title: const Text('Highcharts Flutter Demo')),
          body: Center(
              child: Column(children: [PieChartScreen(), LineChartScreen()])),
        ));
  }
}
