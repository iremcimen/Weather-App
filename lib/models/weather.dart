import 'package:weather_app/models/current.dart';
import 'package:weather_app/models/location.dart';

class Weather {
  const Weather({required this.current, required this.location});

  final Current current;
  final Location location;

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
    );
  }
}
