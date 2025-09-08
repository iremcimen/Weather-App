import 'package:weather_app/models/astro.dart';
import 'package:weather_app/models/day.dart';

class Forecast {
  const Forecast({required this.forecastday});

  final List<ForecastDay> forecastday;

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      forecastday: (json['forecastday'] as List)
          .map((e) => ForecastDay.fromJson(e))
          .toList(),
    );
  }
}

class ForecastDay {
  const ForecastDay({
    required this.date,
    required this.day,
    required this.astro,
  });

  final String date;
  final Day day;
  final Astro astro;

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      date: json['date'] ?? "",
      day: Day.fromJson(json['day']),
      astro: Astro.fromJson(json['astro']),
    );
  }
}
