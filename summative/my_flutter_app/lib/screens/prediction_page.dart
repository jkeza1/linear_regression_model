import 'package:flutter/material.dart';
import 'package:my_flutter_app/services/api_service.dart';

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bodyTempController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();

  double _systolicBP = 120.0;
  String _diastolicBP = "80";
  double _bloodGlucose = 90.0;
  String _predictionResult = '';
  String _errorMessage = ''; // For displaying error messages

  // Function to handle form submission and prediction
  Future<void> _makePrediction() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        'age': int.parse(_ageController.text),
        'systolic_bp': _systolicBP,
        'diastolic_bp': int.parse(_diastolicBP),
        'blood_glucose': _bloodGlucose,
        'body_temp': double.parse(_bodyTempController.text),
        'heart_rate': int.parse(_heartRateController.text),
      };

      try {
        ApiService apiService = ApiService();
        var result = await apiService.sendData(data);
        print('API Response: $result');

        setState(() {
          _errorMessage = '';  // Clear any previous error message
          if (result != null && result.containsKey('prediction')) {
            _predictionResult = result['prediction'].toString();
          } else {
            _predictionResult = 'No prediction received';
          }
        });
      } catch (e) {
        setState(() {
          _predictionResult = '';
          _errorMessage = 'Error: $e';
        });
        print("Error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Health Data'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(  // Wrap the Column with SingleChildScrollView
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

                // Systolic BP Stepper
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
                DropdownButtonFormField<String>(
                  value: _diastolicBP,
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                  items: ["60", "65", "70", "75", "80", "85", "90", "95", "100", "110", "120"]
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
