import 'package:flutter/material.dart';
import 'screens/prediction_page.dart'; // Import the prediction page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Risk Prediction App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, // Optional: Use Material 3 for more modern UI components
      ),
      initialRoute: '/', // Set initial route to the home page
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/prediction': (context) => PredictionPage(), // Route to prediction page
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/prediction'); // Navigate to prediction page
          },
          child: const Text('Go to Prediction Page'),
        ),
      ),
    );
  }
}
