import 'package:flutter/material.dart';
import 'dart:async';

class TrackParcelScreen extends StatefulWidget {
  const TrackParcelScreen({Key? key}) : super(key: key);

  @override
  _TrackParcelScreenState createState() => _TrackParcelScreenState();
}

class _TrackParcelScreenState extends State<TrackParcelScreen> {
  final List<String> _statuses = [
    'Order Confirmed',
    'Truck Assigned',
    'Out for Delivery',
    'Arrived at Destination',
  ];

  int _currentStep = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTracking();
  }

  void _startTracking() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentStep < _statuses.length - 1) {
        setState(() {
          _currentStep++;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Track Your Parcel')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/tracking.gif', // Make sure this gif exists
                height: 200,
              ),
            ),
            SizedBox(height: 20),
            Stepper(
              physics: NeverScrollableScrollPhysics(),
              currentStep: _currentStep,
              steps: _statuses
                  .asMap()
                  .entries
                  .map(
                    (entry) => Step(
                  title: Text(entry.value),
                  content: Text(
                    _currentStep == entry.key
                        ? 'Your parcel is currently at this stage.'
                        : '',
                  ),
                  isActive: _currentStep >= entry.key,
                  state: _currentStep > entry.key
                      ? StepState.complete
                      : (_currentStep == entry.key
                      ? StepState.editing
                      : StepState.indexed),
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
