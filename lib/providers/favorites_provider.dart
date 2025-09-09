import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteCitiesNotifier extends StateNotifier<List<String>> {
  FavoriteCitiesNotifier() : super([]);

  bool toggleCityFavoriteStatus(String city) {
    final cityFavorite = state.contains(city);

    if (cityFavorite) {
      state = state.where((c) => c != city).toList();
      return false;
    } else {
      state = [...state, city];
      return true;
    }
  }
}

final favoriteCitiesProvider =
    StateNotifierProvider<FavoriteCitiesNotifier, List<String>>((ref) {
      return FavoriteCitiesNotifier();
    });
