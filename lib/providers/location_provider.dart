import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/location_services.dart';

final locationProvider = FutureProvider<Position>((ref) async {
  final locationService = LocationService();
  return await locationService.getCurrentLocation();
});
