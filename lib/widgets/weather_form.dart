import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/providers/favorites_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/bottomsheet_service.dart';
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
    final isFavorite = favoriteCities.contains(cityQuery);

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
      padding: const EdgeInsets.only(top: 30),
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withAlpha(230),
                      Colors.blue.shade50.withAlpha(230),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.shade200.withAlpha(50),
                      blurRadius: 18,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
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
                              openFavBottomSheet();
                            }
                          },
                          controller: cityController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a city";
                            }
                            return null;
                          },
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue.shade700,
                              ),
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white.withAlpha(250),
                            prefixIcon: const Icon(
                              Icons.location_city,
                              color: Colors.blueAccent,
                            ),
                            hintText: 'Search city',
                            hintStyle: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Colors.blueGrey.shade400,
                                  fontWeight: FontWeight.w400,
                                ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 14,
                            ),
                            suffixIcon: cityController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.redAccent,
                                    ),
                                    onPressed: () => cityController.clear(),
                                  )
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Material(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          splashColor: Colors.orangeAccent.withAlpha(50),
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              final query = cityController.text.trim();
                              ref.read(cityQueryProvider.notifier).state =
                                  query;
                              openFavBottomSheet();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 14,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Search',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                ),
                              ],
                            ),
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
                            weather?.location.name.toString(),
                            '${weather?.current.tempC.toString()}°C',
                            weather?.current.condition.text.toString(),
                          ];
                          final favTitleList = [
                            'City:',
                            'Temperature:',
                            'Condition:',
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
                            onTap: () {
                              ref
                                  .read(bottomSheetProvider)
                                  .openForecastDay(
                                    context,
                                    weather.forecast.forecastday.first,
                                  );
                            },
                            titleList: favTitleList,
                            detailsList: favDetailsList,
                            url:
                                weather.current.condition.icon.startsWith(
                                  'http',
                                )
                                ? weather.current.condition.icon
                                : 'https:${weather.current.condition.icon}',
                            textButton: TextButton(
                              key: ValueKey('fav-btn-$city'),
                              onPressed: () {
                                ref
                                    .read(favoriteCitiesProvider.notifier)
                                    .toggleCityFavoriteStatus(city);
                              },
                              child: Text(
                                "Remove",
                                style: Theme.of(context).textTheme.titleSmall!
                                    .copyWith(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
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
                    }),
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
