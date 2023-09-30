import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    sliderTheme: SliderThemeData(
      thumbShape: SliderComponentShape.noThumb,
      trackShape: const RoundedRectSliderTrackShape(),
    ),
    dividerColor: Colors.transparent,
    primaryColor: AppColors.mainColor,
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 30,
        color: AppColors.textColor,
      ),
      displayMedium: TextStyle(
        fontSize: 13,
        color: AppColors.textColor,
        fontWeight: FontWeight.w500,
      ),
      displaySmall: TextStyle(
        fontSize: 15,
        color: AppColors.textColor,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 12,
        color: AppColors.mainColor,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        color: AppColors.whiteColor,
        fontWeight: FontWeight.normal,
      ),
    ),
    fontFamily: 'Bahij_TheSansArabic',
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: AppColors.background,
      elevation: 16,
      shadowColor: Colors.white.withOpacity(0.2),
      actionsIconTheme: const IconThemeData(color: Colors.grey),
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        fontSize: 16,
        color: AppColors.textColor,
        fontWeight: FontWeight.w700,
        fontFamily: 'Bahij_TheSansArabic',
      ),
    ),
    scaffoldBackgroundColor: AppColors.background,
  );
}
