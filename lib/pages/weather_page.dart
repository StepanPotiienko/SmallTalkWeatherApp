import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimalistic_weather_app/models/weather_model.dart';
import 'package:minimalistic_weather_app/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('3cd5e77fc4c8494a48428e5c685851e7');
  Weather? _weather;

  final _typesOfWeather = {
    'clouds': 'assets/partly_rain.json',
    'mist': 'assets/partly_rain.json',
    'smoke': 'assets/partly_rain.json',
    'haze': 'assets/partly_rain.json',
    'dust': 'assets/partly_rain.json',
    'fog': 'assets/partly_rain.json'
  };

  _fetchWeather() async {
    String cityName = await _weatherService.getCity();

    try {
      final weather = await _weatherService.getWeather(cityName);

      setState(() {
        _weather = weather;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  String getTheMessageOfTheWeather(String? condition, double temperature) {
    if (_typesOfWeather.keys.contains(condition) &&
        temperature > 0 &&
        temperature < 20) {
      return 'It is a nice day to grab yourself a hot chocolate and good book.';
    }

    return 'It is a nice day today. What about taking a little walk?';
  }

  String? getWeatherAnimation(String? condition) {
    if (condition == null) return 'assets/sunny.json';

    if (_typesOfWeather.containsKey(condition)) {
      return _typesOfWeather[condition];
    }

    return 'assets/sunny.json';
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SmallTalk | ${_weather?.cityName}"),
          backgroundColor: Colors.blue[400],
          elevation: 20,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  "Nice weather for reading a nice book and drinking hot chocolate.",
                  style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
              Lottie.asset(getWeatherAnimation(_weather?.condition) ??
                  "assets/sunny.json"),
              Text(_weather?.condition ?? "Looking at the clouds..."),
              const Divider(),
              Text(
                  '${_weather?.temperature.round()} Celcius | ${_weather!.temperature.round() * (9 / 5) + 32} Fehrenheit')
            ],
          ),
        ));
  }
}
