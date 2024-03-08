import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';


var currentDateStr = (DateTime.now().year * 10000 + DateTime.now().month * 100 + DateTime.now().day).toString();
int cycleCounter = 0;
bool isWorkPhase = true;

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  static const int totalWorkSeconds = 1500;
  int currentSeconds = totalWorkSeconds;
  static const totalRestSeconds = 300;
  int  currentPhaseSecondRemaining = totalWorkSeconds;
  int currentPhaseTotalSeconds = 1500;
  MaterialAccentColor color = Colors.lightGreenAccent;

  Timer? timer;

  String get formattedTime {
    final int mins = currentSeconds ~/ 60;
    final int secs = currentSeconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (currentSeconds > 0) {
        setState(() {
          currentSeconds--;
        });
      } else {
        vibrate();
        switchPhase();
      }
    });
  }

  void switchPhase() {
    timer?.cancel();
    setState(() {
      isWorkPhase = !isWorkPhase;
      if (currentPhaseTotalSeconds == 300) {
        currentPhaseTotalSeconds = 1500;
        currentPhaseSecondRemaining = 1500;
      } else {
        currentPhaseTotalSeconds = 300;
        currentPhaseSecondRemaining = 300;
      }
      changeColor();
      currentSeconds = isWorkPhase ? totalWorkSeconds : totalRestSeconds;
    });
    cycleCounter++;
    startTimer();
  }

  void changeColor() {
    if (color == Colors.lightGreenAccent) {
      color = Colors.deepPurpleAccent;
    } else {
      color = Colors.lightGreenAccent;
    }
  }

  void stopTimer() {
    timer?.cancel();
    setState(() {});
  }

  void vibrate() {
    Vibration.vibrate(duration: 1000, amplitude: 128);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 350,
              height: 350,
              child: CircularProgressIndicator(
                  strokeWidth: 10,
                  color: color,
                  backgroundColor: Colors.grey,
                  value: currentSeconds / currentPhaseTotalSeconds
                  ),
            ),
            Positioned(
              top: 140,
              left: 115,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      formattedTime,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: -3,
                    child: Container(
                      child: ElevatedButton(
                        onPressed: () {
                          if (timer == null || !timer!.isActive) {
                            startTimer();
                          } else {
                            stopTimer();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(130, 40),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                        ),
                        child: null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
