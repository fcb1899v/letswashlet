import 'package:flutter/foundation.dart';

extension StringExt on String {

  void debugPrint() {
    if (kDebugMode) {
      print(this);
    }
  }
}

extension BoolExt on bool {

  bool reverse() => (this) ? false: true;

  String waterImage(int strength) =>
      (this) ? "assets/images/w$strength.gif":
      "assets/images/transparent.png";

  int plusMinus(int strength, int max, int min) =>
      (this && strength < max) ? strength + 1:
      (!this && strength > min) ? strength - 1: strength;
}

extension DoubleExt on double {

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
}

