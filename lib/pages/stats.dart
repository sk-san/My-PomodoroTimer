import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:my_pomodoro/components/timer.dart';


class MyHeatMapCalendar extends StatefulWidget {
  const MyHeatMapCalendar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHeatMapCalendar();
}

class _MyHeatMapCalendar extends State<MyHeatMapCalendar> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController heatLevelController = TextEditingController();

  Map<DateTime, int> heatMapDatasets = {};

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    heatLevelController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Heatmap Calendar'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(20),
              elevation: 20,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: HeatMapCalendar(
                  flexible: true,
                  datasets: heatMapDatasets,
                  colorMode: ColorMode.color,
                  colorsets: const {
                    1: Color.fromARGB(20, 2, 179, 8),
                    2: Color.fromARGB(40, 2, 179, 8),
                    3: Color.fromARGB(50, 2, 179, 8),
                    4: Color.fromARGB(80, 2, 179, 8),
                    5: Color.fromARGB(100, 2, 179, 8),
                    6: Color.fromARGB(120, 2, 179, 8),
                    7: Color.fromARGB(150, 2, 179, 8),
                    8: Color.fromARGB(180, 2, 179, 8),
                    9: Color.fromARGB(220, 2, 179, 8),
                    10: Color.fromARGB(255, 2, 179, 8),
                  },
                ),
              ),
            ),
            ElevatedButton(
              child: const Text('Update'),
              onPressed: () {
                setState(() {
                  // DateTime.parse(dateController.text), heatLevelController.text
                  heatMapDatasets[DateTime.parse(currentDateStr)] = cycleCounter;
                });
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
