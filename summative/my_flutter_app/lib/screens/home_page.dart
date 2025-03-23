import 'package:flutter/material.dart';
import 'prediction_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Linear Regression Prediction')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PredictionPage()),
            );
          },
          child: Text('Go to Prediction'),
        ),
      ),
    );
  }
}
