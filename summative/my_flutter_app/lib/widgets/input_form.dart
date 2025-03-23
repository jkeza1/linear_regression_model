import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final TextEditingController ageController;
  final TextEditingController systolicBpController;
  final TextEditingController diastolicBpController;
  final TextEditingController bloodGlucoseController;
  final TextEditingController bodyTempController;
  final TextEditingController heartRateController;

  InputForm({
    required this.ageController,
    required this.systolicBpController,
    required this.diastolicBpController,
    required this.bloodGlucoseController,
    required this.bodyTempController,
    required this.heartRateController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: ageController,
          decoration: InputDecoration(labelText: 'Age'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: systolicBpController,
          decoration: InputDecoration(labelText: 'Systolic BP'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: diastolicBpController,
          decoration: InputDecoration(labelText: 'Diastolic BP'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: bloodGlucoseController,
          decoration: InputDecoration(labelText: 'Blood Glucose'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: bodyTempController,
          decoration: InputDecoration(labelText: 'Body Temperature'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: heartRateController,
          decoration: InputDecoration(labelText: 'Heart Rate'),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
