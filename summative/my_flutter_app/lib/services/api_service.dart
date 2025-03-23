// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';


class ApiService {
  final String _baseUrl = 'https://linear-regression-model-9-bs8e.onrender.com';

  Future<String> predictRiskLevel({
    required String age,
    required String systolicBp,
    required String diastolicBp,
    required String bloodGlucose,
    required String bodyTemp,
    required String heartRate,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/prediction'),
      headers: {'Content-Type': 'application/json','Access-Control-Allow-Origin': '*', // CORS header is handled by FastAPI
      'Access-Control-Allow-Methods': 'POST', // CORS header is handled by FastAPI
      'Access-Control-Allow-Headers': 'Content-Type'},
      body: jsonEncode({
        'age': age,
        'systolic_bp': systolicBp,
        'diastolic_bp': diastolicBp,
        'blood_glucose': bloodGlucose,
        'body_temp': bodyTemp,
        'heart_rate': heartRate,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['prediction'];
    } else {
      throw Exception('Failed to make prediction');
    }
  }

  sendData(Map<String, dynamic> data) {}
}
