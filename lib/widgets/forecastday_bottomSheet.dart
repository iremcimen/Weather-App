import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:weather_app/models/day.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/widgets/sliver_one_grid.dart';
import 'package:weather_app/widgets/sliver_two_grids.dart';

class ForecastdayBottomsheet extends StatelessWidget {
  const ForecastdayBottomsheet({super.key, required this.fcDay});
  final ForecastDay fcDay;
  @override
  Widget build(BuildContext context) {
    final astro = fcDay.astro;
    final day = fcDay.day;

    final dayDetails = [
      day.maxTempC.toString(),
      day.minTempC.toString(),
      day.uv.toString(),
      day.avgHumidity.toString(),
      day.maxWindKph.toString(),
      day.dailyChanceOfRain.toString(),
    ];
    final dayIcons = [
      Icon(Symbols.thermometer, size: 28, color: Colors.blue.shade800),
      Icon(Symbols.thermometer, size: 28, color: Colors.blue.shade800),
      Icon(Symbols.sunny, size: 28, color: Colors.orange.shade700),
      Icon(Symbols.humidity_percentage, size: 28, color: Colors.blue.shade800),
      Icon(Symbols.air, size: 28, color: Colors.blue.shade800),
      Icon(Symbols.cloud, size: 28, color: Colors.blueGrey.shade700),
    ];
    final moonDetails = [
      astro.moonrise,
      astro.moonset,
      astro.moonPhase,
      astro.moonIllumination.toString(),
    ];
    final moonIcon = Icon(
      Symbols.moon_stars,
      size: 84,
      color: Colors.indigo.shade400,
    );
    final moonTitle = ["Moonrise", "Moonset", "Moon Phase", "Illumination"];
    final sunDetails = [astro.sunrise, astro.sunset];
    final sunTitle = ["Sunrise", "Sunset"];
    final sunIcon = Icon(
      Symbols.sunny,
      size: 84,
      color: Colors.orange.shade400,
    );
    final dayTitle = [
      "Max Temperature",
      "Min Temperature",
      "UV Index",
      "Avarage Humidity",
      "Max Wind",
      "Daily Change of Rain",
    ];
    return CustomScrollView(
      slivers: [
        SliverOneGrid(
          detailsList: sunDetails,
          titleList: sunTitle,
          icon: sunIcon,
        ),
        SliverOneGrid(
          detailsList: moonDetails,
          titleList: moonTitle,
          icon: moonIcon,
        ),
        SliverTwoGrids(
          detailsList: dayDetails,
          titleList: dayTitle,
          gridCount: 2,
          iconsList: dayIcons,
        ),
      ],
    );
  }
}
