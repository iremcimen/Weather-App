import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

class WeatherServices {
  Future<Weather> fetchWeather(String city) async {
    const apiKey = "1538ecf4230747fb92c174735250209";
    final url = Uri.parse(
      "http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=7&aqi=yes&alerts=no",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Weather.fromJson(jsonData);
    } else {
      throw Exception("Hava durumu verisi alınamadı");
    }
  }

  Future<Weather> fetchWeatherLatLon(double lat, double lon) async {
    const apiKey = "1538ecf4230747fb92c174735250209";
    final url = Uri.parse(
      "http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$lat,$lon&days=7&aqi=yes&alerts=no",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Weather.fromJson(jsonData);
    } else {
      throw Exception("Hava durumu verisi alınamadı");
    }
  }
}
