import 'package:flutter/material.dart';
import 'package:my_pomodoro/components/timer.dart';
import 'package:my_pomodoro/pages/stats.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          scrollDirection: Axis.horizontal,
          children:[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TimerPage(),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: MyHeatMapCalendar(),
            )
            ],
        )
      ),
    );
  }
}
