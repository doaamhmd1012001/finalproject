import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(stepcounter_testv2());
}

final _streamSubscriptions = <StreamSubscription<dynamic>>[];

StreamSubscription? _accelerometerStreamSubscription;

int stepCounter = 0;
double previousvalue = 0.0;
bool _isStepUp = false;

class stepcounter_testv2 extends StatefulWidget {
  @override
  State<stepcounter_testv2> createState() => _stepcounter_testv2State();
}
@override
void initState() {
  _initAccelerometer();
}

@override
void dispose() {
  _stopAccelerometer();
}

void _initAccelerometer() {
  _accelerometerStreamSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
    double y = event.y;
    double magnitude = sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
    double delta = magnitude - previousvalue;

    if (delta > 2.0 && !_isStepUp && magnitude > 11.0) {
      stepCounter;
      _isStepUp = true;
        stepCounter = stepCounter;
    } else if (delta < -2.0) {
      _isStepUp = false;
    }

    previousvalue = magnitude;
  });
}

void _stopAccelerometer() {
  _accelerometerStreamSubscription?.cancel();
  _accelerometerStreamSubscription = null;
}

class _stepcounter_testv2State extends State<stepcounter_testv2> {
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Step Counter'),
    ),
    body: Center(
      child: Text(
        'the step counter for the user: $stepCounter',style: TextStyle(fontSize: 30),
      ),
    ),
  );
}

  }

