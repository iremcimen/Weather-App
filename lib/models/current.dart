class Current {
  const Current({
    required this.tempC,
    required this.tempF,
    required this.feelC,
    required this.feelF,
    required this.windKph,
    required this.humidity,
    required this.cloud,
    required this.precipMm,
    required this.uv,
    required this.visionKm,
    required this.pressureMb,
    required this.condition,
    required this.windDirection,
  });

  final double tempC;
  final double feelC;
  final double tempF;
  final double feelF;
  final double windKph;
  final double humidity;
  final double cloud;
  final String windDirection;
  final double precipMm; //yağış miktarı
  final double uv;
  final double visionKm; //görüş mesafesi
  final double pressureMb;
  final Condition condition;

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      tempC: (json['temp_c'] as num?)?.toDouble() ?? 0.0,
      tempF: (json['temp_f'] as num?)?.toDouble() ?? 0.0,
      feelC: (json['feelslike_c'] as num?)?.toDouble() ?? 0.0,
      feelF: (json['feelslike_f'] as num?)?.toDouble() ?? 0.0,
      cloud: (json['cloud'] as num?)?.toDouble() ?? 0.0,
      humidity: (json['humidity'] as num?)?.toDouble() ?? 0.0,
      windKph: (json['wind_kph'] as num?)?.toDouble() ?? 0.0,
      precipMm: (json['precip_mm'] as num?)?.toDouble() ?? 0.0,
      uv: (json['uv'] as num?)?.toDouble() ?? 0.0,
      visionKm: (json['vis_km'] as num?)?.toDouble() ?? 0.0,
      pressureMb: (json['pressure_mb'] as num?)?.toDouble() ?? 0.0,
      windDirection: json['wind_dir'] ?? '',
      condition: Condition.fromJson(json['condition'] ?? {}),
    );
  }
}

class Condition {
  const Condition({required this.icon, required this.text});

  final String text;
  final String icon;

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(text: json['text'], icon: json['icon']);
  }
}
