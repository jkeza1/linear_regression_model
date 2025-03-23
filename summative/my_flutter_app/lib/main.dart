import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_page.dart';
import 'screens/prediction_page.dart';

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
        '/home': (context) => HomePage(),
        '/predict': (context) => PredictionPage(),
      },
    );
  }
}