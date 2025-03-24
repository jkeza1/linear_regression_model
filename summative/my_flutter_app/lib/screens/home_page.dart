import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_flutter_app/screens/prediction_page.dart';

class PredictionInputScreen extends StatefulWidget {
  const PredictionInputScreen({super.key});

  @override
  _PredictionInputScreenState createState() => _PredictionInputScreenState();
}

class _PredictionInputScreenState extends State<PredictionInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _inputValues = {
    'Age': '',
    'SystolicBP': '',
    'DiastolicBP': '',
    'Blood_glucose': '',
    'HeartRate': '',
  };
  bool _isLoading = false;

  // Function to call the API
  Future<void> _predict() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      setState(() {
        _isLoading = true;
      });
      
      try {
        const String baseUrl = 'https://linear-regression-model-10-l1dl.onrender.com';
        const String predictPath = 'predict';
        final url = Uri.parse('$baseUrl/$predictPath');

        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(_inputValues),
        );

        setState(() {
          _isLoading = false;
        });

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          // Extract the predicted body temperature
          final predictedTemperature = responseBody['predicted_body_temperature'];
          
          // Navigate to result screen
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PredictionResultScreen(
                temperature: predictedTemperature.toString(),
                inputValues: _inputValues,
              ),
            ),
          );
        } else {
          _showErrorSnackBar('Failed to load prediction: ${response.statusCode}');
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        _showErrorSnackBar('Error: ${e.toString()}');
      }
    }
  }
  
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TempPredict'),
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2E7D32),
              Color(0xFFF5F5F5),
            ],
            stops: [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const Text(
                        'Enter Health Parameters',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25),
                      
                      _buildInputField(
                        label: 'Age',
                        hint: 'Enter age in years',
                        icon: Icons.person,
                        field: 'Age',
                      ),
                      
                      _buildInputField(
                        label: 'Systolic BP',
                        hint: 'Enter systolic blood pressure',
                        icon: Icons.favorite,
                        field: 'SystolicBP',
                      ),
                      
                      _buildInputField(
                        label: 'Diastolic BP',
                        hint: 'Enter diastolic blood pressure',
                        icon: Icons.favorite_border,
                        field: 'DiastolicBP',
                      ),
                      
                      _buildInputField(
                        label: 'Blood Glucose',
                        hint: 'Enter blood glucose level',
                        icon: Icons.opacity,
                        field: 'Blood_glucose',
                      ),
                      
                      _buildInputField(
                        label: 'Heart Rate',
                        hint: 'Enter heart rate (BPM)',
                        icon: Icons.monitor_heart,
                        field: 'HeartRate',
                      ),
                      
                      const SizedBox(height: 30),
                      
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _predict,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2,
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  'PREDICT TEMPERATURE',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required IconData icon,
    required String field,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: const Color(0xFF2E7D32)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        keyboardType: TextInputType.number,
        onSaved: (value) => _inputValues[field] = value!,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          if (double.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
          return null;
        },
      ),
    );
  }
}