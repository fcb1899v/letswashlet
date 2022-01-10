import 'package:flutter/foundation.dart';

extension StringExt on String {

  void debugPrint() {
    if (kDebugMode) {
      print(this);
    }
  }
}

extension BoolExt on bool {

  String waterImage(int strength) =>
      (this) ? "assets/images/w$strength.gif":
      "assets/images/transparent.png";

  int plusMinus(int strength, int max, int min) =>
      (this && strength < max) ? strength + 1:
      (!this && strength > min) ? strength - 1: strength;
}

extension DoubleExt on double {

  double appBarHeight() => (this < 660) ? (this - 60) / 10 + 20: 80;
  double titleScaleFactor() => (this < 510) ? (this - 60) / 300: 1.5;

  double circleButtonSize() => (this < 660) ? (this - 60) / 3: 200.0;
  double circleButtonPadding() => (this < 660) ? (this - 60) / 30: 20.0;
  double circleBorderWidth() => (this < 660) ? (this - 60) / 60: 10.0;

  double smallButtonSize() => (this < 660) ? (this - 60) / 5: 120.0;
  double smallButtonPadding() => (this < 660) ? (this - 60) / 60: 10.0;
  double smallBorderWidth() => (this < 660) ? (this - 60) / 100: 6.0;
  double smallButtonMarginTop() => (this < 660) ? (this - 60) / 30: 20.0;
  double smallButtonMarginBottom() => (this < 660) ? (this - 60) / 60: 10.0;

  double plusMinusButtonSize() => (this < 660) ? (this - 60) / 6: 100.0;
  double plusMinusButtonPadding() => (this < 600) ? (this - 60) / 60: 10.0;
  double plusMinusScaleFactor() => (this < 660) ? (this - 60) / 300: 2.0;
  double plusMinusBorderWidth() => (this < 660) ? (this - 60) / 100: 6.0;
  double plusMinusMarginSize() => (this < 660) ? (this - 60) / 60: 10.0;

  double lampSize() => (this < 660) ? (this - 60) / 25 + 4: 28.0;
  double lampPadding() => (this < 660) ? (this - 60) / 120: 5.0;

  double admobHeight() => (this < 680) ? 50: (this < 1180) ? 50 + (this - 680) / 10: 100;
  double admobWidth() => this - 100;

}

