import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/weather.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:weather_app/widgets/forecastday_bottomSheet.dart';
import 'package:weather_app/widgets/sliver_two_grids.dart';
import 'package:weather_app/widgets/weather_sliver_appbar.dart';

class WeatherCityItem extends ConsumerWidget {
  const WeatherCityItem({super.key, required this.weather});
  final Weather weather;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = weather.current;
    final forecast = weather.forecast.forecastday;

    void openForecastDay(ForecastDay fcDay) {
      showModalBottomSheet(
        scrollControlDisabledMaxHeightRatio: 0.7,
        showDragHandle: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        backgroundColor: Colors.blue.shade300,
        useSafeArea: true,
        elevation: 5,
        context: context,
        builder: (context) {
          return ForecastdayBottomsheet(fcDay: fcDay);
        },
      );
    }

    String changeUv() {
      double uv = current.uv.toDouble();
      if (uv < 3) {
        return 'Low';
      } else if (uv > 5) {
        return 'High';
      } else {
        return 'Mid';
      }
    }

    final currentDetails = [
      '${current.feelC.toString()}°C',
      '%${current.humidity.toString().split('.').first}',
      '${current.uv.toString().split('.').first}\n${changeUv()}',
      '${current.visionKm.toString()} km',
      '${current.windKph.toString()} kph',
      current.windDirection.toString(),
      current.cloud == 0.0
          ? 'No cloud'
          : '%${current.cloud.toString().split('.').first}',
      '${current.precipMm.toString()} mm',
      '${current.pressureMb.toString()} mb',
    ];

    final icon = [
      Icon(Symbols.thermometer, size: 28, color: Colors.blue.shade800),
      Icon(Symbols.humidity_percentage, size: 28, color: Colors.blue.shade800),
      Icon(Symbols.sunny, size: 28, color: Colors.orange.shade700),
      Icon(Symbols.visibility, size: 28, color: Colors.blueGrey.shade700),
      Icon(Symbols.air, size: 28, color: Colors.blue.shade800),
      Icon(
        Symbols.navigation,
        size: 28,
        color: Colors.blueGrey.shade700,
      ), // wind direction
      Icon(Symbols.cloud, size: 28, color: Colors.blueGrey.shade700),
      Icon(Symbols.humidity_high, size: 28, color: Colors.blue.shade800),
      Icon(
        Symbols.swap_driving_apps_wheel,
        size: 28,
        color: Colors.blueGrey.shade700,
      ),
    ];

    final currentTitle = [
      "Feels Like",
      "Humidity",
      "UV Index",
      "Vision",
      "Wind",
      "Wind Dir.",
      "Cloud",
      "Precip",
      "Pressure",
    ];

    return CustomScrollView(
      slivers: [
        WeatherSliverAppBar(weather: weather),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 140,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              scrollDirection: Axis.horizontal,
              itemCount: forecast.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final fcDay = forecast[index];
                final iconUrl = fcDay.day.condition.icon.startsWith('http')
                    ? fcDay.day.condition.icon
                    : 'https:${fcDay.day.condition.icon}';
                return Container(
                  width: 110,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade50, Colors.blue.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(15),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      openForecastDay(fcDay);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            fcDay.date,
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          SizedBox(
                            width: 48,
                            height: 48,
                            child: Image.network(
                              iconUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.cloud_outlined,
                                color: Colors.blue.shade300,
                                size: 40,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${fcDay.day.maxTempC}° / ${fcDay.day.minTempC}°',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SliverTwoGrids(
          detailsList: currentDetails,
          titleList: currentTitle,
          gridCount: 2,
          iconsList: icon,
        ),
      ],
    );
  }
}
