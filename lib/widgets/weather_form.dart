import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/providers/favorites_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/widgets/fav_bottomsheet.dart';
import 'package:weather_app/widgets/sliver_one_grid.dart';

class WeatherForm extends ConsumerWidget {
  const WeatherForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityQuery = ref.watch(cityQueryProvider);
    final cityController = ref.watch(citySearchControllerProvider);
    final formKey = GlobalKey<FormState>();
    final favoriteCities = ref.watch(favoriteCitiesProvider);

    void openFavBottomSheet() {
      showModalBottomSheet(
        scrollControlDisabledMaxHeightRatio: 0.85,
        enableDrag: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.blue.shade300,
        useSafeArea: true,
        elevation: 5,
        context: context,
        builder: (context) {
          return FavBottomsheet();
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          textInputAction: TextInputAction.search,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              final query = cityController.text.trim();
                              ref.read(cityQueryProvider.notifier).state =
                                  query;
                            }
                          },
                          controller: cityController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a city";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                            prefixIcon: const Icon(Icons.location_city),
                            hintText: 'Search city',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 12,
                            ),
                            suffixIcon: cityController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () => cityController.clear(),
                                  )
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final query = cityController.text.trim();
                            ref.read(cityQueryProvider.notifier).state = query;
                            openFavBottomSheet();
                          }
                        },
                        icon: const Icon(Icons.search),
                        label: const Text('Search'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    ...favoriteCities.map((city) {
                      final weatherAsync = ref.watch(
                        fetchCityWeatherProvider(city),
                      );

                      return weatherAsync.when(
                        data: (weather) {
                          final favDetailsList = [
                            weather?.current.tempC.toString(),
                            weather?.location.name.toString(),
                            weather?.current.condition.text.toString(),
                          ];
                          if (weather == null) {
                            return SliverToBoxAdapter(
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.search_off, size: 48),
                                    const SizedBox(height: 8),
                                    Text(
                                      'No data found',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return SliverOneGrid(
                            detailsList: favDetailsList,
                            url: weather.current.condition.text,
                          );
                        },
                        error: (err, stack) => SliverToBoxAdapter(
                          child: Center(
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
                        loading: () => const SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
