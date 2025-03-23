import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String prediction;

  ResultPage({required this.prediction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prediction Result')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Predicted Risk Level:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                prediction,
                style: TextStyle(fontSize: 28, color: Colors.blue),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go Back to Prediction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
