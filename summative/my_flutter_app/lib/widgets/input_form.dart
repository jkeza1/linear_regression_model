import 'package:flutter/material.dart';

class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController ageController = TextEditingController();
  final TextEditingController systolicBpController = TextEditingController();
  final TextEditingController diastolicBpController = TextEditingController();
  final TextEditingController bloodGlucoseController = TextEditingController();
  final TextEditingController bodyTempController = TextEditingController();
  final TextEditingController heartRateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: ageController,
            decoration: const InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your age';
              }
              return null;
            },
          ),
          TextFormField(
            controller: systolicBpController,
            decoration: const InputDecoration(labelText: 'Systolic BP'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter systolic BP';
              }
              return null;
            },
          ),
          TextFormField(
            controller: diastolicBpController,
            decoration: const InputDecoration(labelText: 'Diastolic BP'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter diastolic BP';
              }
              return null;
            },
          ),
          TextFormField(
            controller: bloodGlucoseController,
            decoration: const InputDecoration(labelText: 'Blood Glucose'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter blood glucose';
              }
              return null;
            },
          ),
          TextFormField(
            controller: bodyTempController,
            decoration: const InputDecoration(labelText: 'Body Temperature'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter body temperature';
              }
              return null;
            },
          ),
          TextFormField(
            controller: heartRateController,
            decoration: const InputDecoration(labelText: 'Heart Rate'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter heart rate';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                Map<String, dynamic> data = {
                  'age': int.parse(ageController.text),
                  'systolic_bp': int.parse(systolicBpController.text),
                  'diastolic_bp': int.parse(diastolicBpController.text),
                  'blood_glucose': double.parse(bloodGlucoseController.text),
                  'body_temp': double.parse(bodyTempController.text),
                  'heart_rate': int.parse(heartRateController.text),
                };
                // You can now send `data` to your backend for prediction.
                // For example, send it to the API here
                print(data);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
