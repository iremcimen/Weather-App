import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/providers/weather_provider.dart';

class WeathersScreen extends ConsumerStatefulWidget {
  const WeathersScreen({super.key});
  @override
  ConsumerState<WeathersScreen> createState() {
    return _WeathersScreenState();
  }
}

class _WeathersScreenState extends ConsumerState<WeathersScreen> {
  @override
  Widget build(BuildContext context) {
    final cityController = ref.watch(citySearchControllerProvider);
    final cityQuery = ref.watch(cityQueryProvider);
    final weatherAsync = ref.watch(fetchCityWeatherProvider(cityQuery));
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: const Text("Weather")),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: cityController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a city";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text("City"),
                  hintText: "Enter a City",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final query = cityController.text.trim();
                    ref.read(cityQueryProvider.notifier).state = query;
                  }
                },
                child: const Text("Search"),
              ),
              Expanded(
                child: weatherAsync.when(
                  data: (weather) {
                    if (cityQuery.isEmpty) {
                      return const Center(
                        child: Text("Lütfen bir şehir girin"),
                      );
                    }
                    if (weather == null) {
                      return const Center(child: Text("Veri bulunamadı"));
                    }
                    return Center(
                      child: Text(
                        "Şehir: ${weather.location.name} - Ülke: ${weather.location.country}\nSıcaklık: ${weather.current.tempC.toStringAsFixed(1)}°C",
                      ),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text("Hata: $err")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
