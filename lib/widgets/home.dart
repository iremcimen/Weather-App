import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/widgets/weather_city_item.dart';
import '../providers/location_provider.dart';
import '../providers/weather_provider.dart';

class Home extends ConsumerWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAsync = ref.watch(locationProvider);
    return locationAsync.when(
      data: (position) {
        final weatherAsync = ref.watch(weatherProvider(position));
        return weatherAsync.when(
          data: (weather) {
            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: WeatherCityItem(weather: weather),
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(
            child: Text(
              'Hava durumu alınamadı: $err',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(
        child: Text(
          'Konum alınamadı: $err',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
