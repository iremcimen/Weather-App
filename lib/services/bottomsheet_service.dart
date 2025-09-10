import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/widgets/fav_bottomsheet.dart';

final bottomSheetProvider = Provider<BottomSheetService>((ref) {
  return BottomSheetService();
});

class BottomSheetService {
  void openForecastDay(BuildContext context, ForecastDay fcDay) {
    showModalBottomSheet(
      scrollControlDisabledMaxHeightRatio: 0.7,
      showDragHandle: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.blueAccent.shade100,
      useSafeArea: true,
      elevation: 5,
      context: context,
      builder: (context) {
        return FavBottomsheet();
      },
    );
  }
}
