class Astro {
  const Astro({
    required this.sunset,
    required this.sunrise,
    required this.moonset,
    required this.moonrise,
    required this.moonPhase,
    required this.moonIllumination,
  });
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;
  final int moonIllumination;

  factory Astro.fromJson(Map<String, dynamic> json) {
    return Astro(
      sunset: json['sunset'] ?? "",
      sunrise: json['sunrise'] ?? "",
      moonset: json['moonset'] ?? "",
      moonrise: json['moonrise'] ?? "",
      moonPhase: json['moon_phase'] ?? "",
      moonIllumination: json['moon_illumination'] ?? 0,
    );
  }
}
