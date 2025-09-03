import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

class WeatherServices {
  Future<Weather> fetchWeather(String city) async {
    const apiKey = "cdbf01c77cce40a1898174805250209";
    final url = Uri.parse(
      "http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city&aqi=no",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Weather.fromJson(jsonData);
    } else {
      throw Exception("Hava durumu verisi alınamadı.");
    }
  }
}
