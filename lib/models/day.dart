import 'package:weather_app/models/current.dart';

class Day {
  const Day({
    required this.maxTempC,
    required this.minTempC,
    required this.condition,
    required this.maxWindKph,
    required this.avgHumidity,
    required this.dailyChanceOfRain,
    required this.uv,
  });
  final double maxTempC;
  final double minTempC;
  final double maxWindKph;
  final int avgHumidity;
  final int dailyChanceOfRain;
  final double uv;
  final Condition condition;

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxTempC: (json['maxtemp_c'] as num?)?.toDouble() ?? 0.0,
      minTempC: (json['mintemp_c'] as num?)?.toDouble() ?? 0.0,
      maxWindKph: (json['maxwind_kph'] as num?)?.toDouble() ?? 0.0,
      avgHumidity: (json['avghumidity'] as int?) ?? 0,
      dailyChanceOfRain: (json['daily_chance_of_rain'] as int?) ?? 0,
      uv: (json['uv'] as num?)?.toDouble() ?? 0.0,
      condition: Condition.fromJson(json['condition'] ?? {}),
    );
  }
}
