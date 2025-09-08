import 'package:weather_app/models/current.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/location.dart';

class Weather {
  const Weather({required this.current, required this.location, required this.forecast});

  final Current current;
  final Location location;
  final Forecast forecast;

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }
}
