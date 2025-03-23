import 'package:flutter/material.dart';

class PredictionButton extends StatelessWidget {
  final VoidCallback onPressed;

  PredictionButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('Predict'),
    );
  }
}
