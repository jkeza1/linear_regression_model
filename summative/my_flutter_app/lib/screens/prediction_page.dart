import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Prediction',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PredictionPage(),
    );
  }
}

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bodyTempController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();

  double _systolicBP = 120.0;
  int _diastolicBP = 80; // diastolic BP as integer
  double _bloodGlucose = 90.0;
  String _predictionResult = '';
  String _errorMessage = '';

  // Function to handle form submission and prediction
  Future<void> _makePrediction() async {
    if (_formKey.currentState!.validate()) {
      // Prepare data to send to the API
      Map<String, dynamic> data = {
        'age': int.parse(_ageController.text), // Convert age to int
        'systolic_bp': _systolicBP.toInt(), // Ensure systolic BP is an int
        'diastolic_bp': _diastolicBP, // Diastolic BP is already int
        'blood_glucose': _bloodGlucose, // Blood glucose is a float
        'body_temp': double.parse(_bodyTempController.text), // Body temperature is a float
        'heart_rate': int.parse(_heartRateController.text), // Convert heart rate to int
      };

      try {
        // Send data to the FastAPI backend
        final response = await http.post(
          Uri.parse('http://127.0.0.1:8000/predict'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(data),
        );

        if (response.statusCode == 200) {
          // If the server returns a successful response
          final result = json.decode(response.body);
          setState(() {
            if (result.containsKey('predicted_risk_level')) {  // Adjusted key
              _predictionResult = result['predicted_risk_level'].toString();  // Adjusted key
            } else {
              _predictionResult = 'No prediction received';
            }
          });
        } else {
          setState(() {
            _errorMessage = 'Error: ${response.statusCode}';
          });
        }
      } catch (e) {
        setState(() {
          _predictionResult = '';
          _errorMessage = 'Error: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Data Prediction'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Age Input
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your age'
                      : null,
                ),
                const SizedBox(height: 16),

                // Systolic BP Slider
                Text('Systolic Blood Pressure: ${_systolicBP.toStringAsFixed(0)} mmHg', style: const TextStyle(fontSize: 16)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (_systolicBP > 90) _systolicBP -= 5;
                        });
                      },
                    ),
                    Text(_systolicBP.toStringAsFixed(0),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          if (_systolicBP < 180) _systolicBP += 5;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Diastolic BP Dropdown
                const Text('Diastolic Blood Pressure:', style: TextStyle(fontSize: 16)),
                DropdownButtonFormField<int>(
                  value: _diastolicBP,
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                  items: [60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120]
                      .map((value) => DropdownMenuItem(value: value, child: Text('$value mmHg')))
                      .toList(),
                  onChanged: (value) => setState(() => _diastolicBP = value!),
                ),
                const SizedBox(height: 16),

                // Blood Glucose Slider
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Blood Glucose Level: ${_bloodGlucose.toStringAsFixed(1)} mg/dL',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Slider(
                      value: _bloodGlucose,
                      min: 50.0,
                      max: 300.0,
                      divisions: 50,
                      label: _bloodGlucose.toStringAsFixed(1),
                      onChanged: (newValue) {
                        setState(() {
                          _bloodGlucose = newValue;
                        });
                      },
                    ),
                  ],
                ),

                // Body Temperature Input
                TextFormField(
                  controller: _bodyTempController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Body Temperature',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter body temperature'
                      : null,
                ),
                const SizedBox(height: 16),

                // Heart Rate Input
                TextFormField(
                  controller: _heartRateController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Heart Rate',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter heart rate'
                      : null,
                ),
                const SizedBox(height: 32),

                // Prediction Button
                ElevatedButton(
                  onPressed: _makePrediction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 179, 131, 227),
                  ),
                  child: const Text('Make Prediction'),
                ),
                const SizedBox(height: 32),

                // Display the result
                if (_predictionResult.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Prediction Result: $_predictionResult',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                // Display the error message if any
                if (_errorMessage.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Error: $_errorMessage',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
