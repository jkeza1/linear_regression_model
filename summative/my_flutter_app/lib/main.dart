import 'package:flutter/material.dart';
import 'package:my_flutter_app/screens/home_page.dart';
import 'package:my_flutter_app/screens/prediction_page.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prediction App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => const PredictionInputScreen(),
        '/predict': (context) => PredictionResultScreen(temperature: '', inputValues: {},),
      },
    );
  }
}