import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/models/weather.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class WeatherCityItem extends ConsumerWidget {
  const WeatherCityItem({super.key, required this.weather});
  final Weather weather;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = weather.current;
    final location = weather.location;

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

    final details = [
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
        SliverAppBar(
          pinned: true,
          floating: false,
          expandedHeight: 180,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          collapsedHeight: 140,
          elevation: 0,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              final percent =
                  (constraints.maxHeight - kToolbarHeight) /
                  (180 - kToolbarHeight);

              return Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade50, Colors.blue.shade100],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          current.condition.icon.startsWith('http')
                              ? current.condition.icon
                              : 'https:${current.condition.icon}',
                          width: 84 * percent.clamp(0.5, 1.0),
                          height: 84 * percent.clamp(0.5, 1.0),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${current.tempC}°C',
                                style: Theme.of(context).textTheme.displayMedium
                                    ?.copyWith(
                                      fontSize: 36 * percent.clamp(0.5, 1.0),
                                      color: Colors.blue.shade700,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                location.name,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      fontSize: 20 * percent.clamp(0.5, 1.0),
                                      color: Colors.blue.shade900,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                current.condition.text,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      fontSize: 16 * percent.clamp(0.5, 1.0),
                                      color: Colors.blueGrey.shade700,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade50, Colors.blue.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      icon[index],
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentTitle[index],
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Colors.blueGrey.shade800,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              details[index],
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    color: Colors.blue.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              childCount: details.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          ),
        ),
      ],
    );
  }
}
