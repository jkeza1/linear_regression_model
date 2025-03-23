import 'package:flutter/material.dart';

class PredictionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  // Constructor with optional label parameter, default is 'Predict'
  PredictionButton({
    required this.onPressed,
    this.label = 'Predict',  // Default value for label
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0), backgroundColor: Colors.deepPurple, // You can customize the color here
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
