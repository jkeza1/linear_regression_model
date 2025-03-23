import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _inputValues = {
    'Age': '',
    'SystolicBP': '',
    'DiastolicBP': '',
    'Blood_glucose': '',
    'HeartRate': '',
  };
  String _predictionResult = '';

  // Function to call the API
  Future<void> _predict() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        const String baseUrl = 'https://linear-regression-model-10-l1dl.onrender.com';
        const String predictPath = 'predict';
        final url = Uri.parse('$baseUrl/$predictPath');

        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(_inputValues),
        );

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          // Extract the predicted body temperature
          final predictedTemperature = responseBody['predicted_body_temperature'];
          setState(() {
            _predictionResult = 'Predicted Body Temperature: $predictedTemperature°F';
          });
        } else {
          throw Exception('Failed to load prediction: ${response.statusCode}');
        }
      } catch (e) {
        setState(() {
          _predictionResult = 'Error: ${e.toString()}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prediction Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Input field for Age
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _inputValues['Age'] = value!,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              // Input field for SystolicBP
              TextFormField(
                decoration: InputDecoration(labelText: 'SystolicBP'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _inputValues['SystolicBP'] = value!,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              // Input field for DiastolicBP
              TextFormField(
                decoration: InputDecoration(labelText: 'DiastolicBP'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _inputValues['DiastolicBP'] = value!,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              // Input field for Blood Glucose
              TextFormField(
                decoration: InputDecoration(labelText: 'Blood Glucose'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _inputValues['Blood_glucose'] = value!,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              // Input field for Heart Rate
              TextFormField(
                decoration: InputDecoration(labelText: 'Heart Rate'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _inputValues['HeartRate'] = value!,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 20),
              // Predict button
              ElevatedButton(
                onPressed: _predict,
                child: Text('Predict'),
              ),
              SizedBox(height: 20),
              // Display prediction result or error message
              Text(
                _predictionResult,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}