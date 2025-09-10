import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';

class WeatherSliverAppBar extends StatelessWidget {
  const WeatherSliverAppBar({super.key, required this.weather});
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final current = weather.current;
    final location = weather.location;

    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
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
              (constraints.maxHeight - kToolbarHeight) / (180 - kToolbarHeight);
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
    );
  }
}
