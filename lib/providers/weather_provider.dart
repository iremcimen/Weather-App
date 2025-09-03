import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_services.dart';

final weatherServiceProvider = Provider<WeatherServices>(
  (ref) => WeatherServices(),
);

final citySearchControllerProvider =
    Provider.autoDispose<TextEditingController>((ref) {
      final c = TextEditingController();
      ref.onDispose(c.dispose);
      return c;
    });

final cityQueryProvider = StateProvider.autoDispose<String>((ref) => "");

final fetchCityWeatherProvider = FutureProvider.autoDispose
    .family<Weather?, String>((ref, city) async {
      final query = city.trim();
      if (query.isEmpty) return null;
      final service = ref.watch(weatherServiceProvider);
      return service.fetchWeather(query);
    });
