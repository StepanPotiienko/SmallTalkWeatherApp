import 'package:flutter/material.dart';
import 'package:minimalistic_weather_app/pages/weather_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'NotoSerif'),
      debugShowCheckedModeBanner: false,
      home: const WeatherPage(),
    );
  }
}
