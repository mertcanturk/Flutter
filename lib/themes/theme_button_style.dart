import 'package:flutter/material.dart';
import 'package:halisahaapp/constants/app_constants.dart';
import 'package:halisahaapp/constants/theme_colors.dart';

class ThemeButtonStyle extends ButtonStyle {
  ThemeButtonStyle({
    bool isReady = true,
  }) : super(
          foregroundColor:
              isReady ? null : MaterialStateProperty.all(ThemeColors.white),
          backgroundColor:
              isReady ? null : MaterialStateProperty.all(ThemeColors.rose),
        );

  ThemeButtonStyle.large({
    bool isReady = true,
  }) : super(
          foregroundColor:
              isReady ? null : MaterialStateProperty.all(ThemeColors.white),
          backgroundColor:
              isReady ? null : MaterialStateProperty.all(ThemeColors.rose),
          minimumSize: MaterialStateProperty.all(
            const Size.fromHeight(AppConstants.heightButtonLarge),
          ),
        );

  ThemeButtonStyle.alt()
      : super(
          foregroundColor: MaterialStateProperty.all(ThemeColors.black),
          side: MaterialStateProperty.all(
            const BorderSide(
              color: ThemeColors.black,
            ),
          ),
        );
}
