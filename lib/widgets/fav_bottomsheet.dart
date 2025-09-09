import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/providers/favorites_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/widgets/weather_city_item.dart';

class FavBottomsheet extends ConsumerWidget {
  const FavBottomsheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityQuery = ref.watch(cityQueryProvider);
    final weatherAsync = ref.watch(fetchCityWeatherProvider(cityQuery));

    final favoriteCities = ref.watch(favoriteCitiesProvider);
    final isFavorite = favoriteCities.contains(cityQuery);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Exit',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  ref
                      .read(favoriteCitiesProvider.notifier)
                      .toggleCityFavoriteStatus(cityQuery);
                },
                icon: AnimatedSwitcher(
                  duration: Duration(milliseconds: 150),
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    alignment: Alignment(0, 3),
                    child: child,
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red.shade500,
                    key: ValueKey(isFavorite),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: weatherAsync.when(
            data: (weather) {
              if (cityQuery.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cloud_queue,
                        size: 56,
                        color: Colors.blue.shade200,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Type a city and tap Search',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                );
              }
              if (weather == null) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.search_off, size: 48),
                      const SizedBox(height: 8),
                      Text(
                        'No data found',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                );
              }
              return WeatherCityItem(weather: weather);
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Error fetching weather',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    err.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
