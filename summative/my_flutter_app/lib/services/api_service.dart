// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String _baseUrl = 'https://linear-regression-model-9-bs8e.onrender.com';

  // Function to predict risk level by sending data to the backend
  Future<String> predictRiskLevel({
    required String age,
    required String systolicBp,
    required String diastolicBp,
    required String bloodGlucose,
    required String bodyTemp,
    required String heartRate,
  }) async {
    // Validate input data
    if (age.isEmpty || systolicBp.isEmpty || diastolicBp.isEmpty || 
        bloodGlucose.isEmpty || bodyTemp.isEmpty || heartRate.isEmpty) {
      throw Exception('Please fill in all the fields');
    }

    // Send POST request to API
    final response = await http.post(
      Uri.parse('$_baseUrl/predict'),
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode({
        'age': age,
        'systolic_bp': systolicBp,
        'diastolic_bp': diastolicBp,
        'blood_glucose': bloodGlucose,
        'body_temp': bodyTemp,
        'heart_rate': heartRate,
      }),
    );

    // Handle response
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('predicted_risk_level') &&
          responseBody['predicted_risk_level'] != null) {
        return responseBody['predicted_risk_level'].toString();
      } else {
        return 'No prediction received';
      }
    } else {
      // If the response status is not 200, throw an exception
      throw Exception('Failed to make prediction. Status code: ${response.statusCode}');
    }
  }
}
