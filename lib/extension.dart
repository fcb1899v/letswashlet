import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'constant.dart';

extension StringExt on String {

  void debugPrint() {
    if (kDebugMode) {
      print(this);
    }
  }
}

extension IntExt on int {

  double washVolume() => 1.5 * this;
  double musicVolume() => 4 * this - 3;
  Color lampColor(int volume, Color? color) =>
      (this == volume) ? color! : Colors.black;
}

extension BoolExt on bool {

  String waterImage(int strength) =>
      (this) ? "assets/images/w$strength.gif": transpImage;

  int plusMinus(int strength, int max, int min) =>
      (this && strength < max) ? strength + 1:
      (!this && strength > min) ? strength - 1: strength;

  double nozzleLength() => (this) ? 0.04: 0;
}

extension DoubleExt on double {

  //App Bar
  double appBarHeight() => (this < 660) ? (this - 60) / 10 + 20: 80;
  double titleScaleFactor() => (this < 510) ? (this - 60) / 300: 1.5;

  //Button
  double washButtonSize() => (this < 660) ? (this - 120) / 3: 180.0;
  double musicButtonSize() => (this < 660) ? (this - 60) / 5: 120.0;
  double volumeButtonSize() => (this < 660) ? (this - 60) / 60 * 7: 70.0;
  double volumeScaleFactor() => (this < 660) ? (this - 60) / 300: 2.0;
  double flushButtonWidth() => (this < 660) ? (this - 60) / 2.5: 240.0;
  double flushButtonHeight() => (this < 660) ? (this - 30) / 7: 90.0;
  double thickBorderWidth() => (this < 660) ? (this - 60) / 60: 10.0;
  double thinBorderWidth() => (this < 660) ? (this - 60) / 100: 6.0;
  double buttonRadius() => (this < 600) ? (this - 60) / 40: 15.0;
  double buttonSpace() => (this < 660) ? (this - 60) / 30: 20.0;

  //Lamp
  double lampSize() => (this < 660) ? (this - 60) / 25: 24.0;
  double lampPadding() => (this < 660) ? (this - 60) / 150: 4.0;
  double lampSpace() => (this < 660) ? (this - 60) / 120: 5.0;
  double lampSideSpace() => (this < 660) ? (this - 60) / 40: 15.0;

  //Admob
  double admobHeight() => (this < 680) ? 50: (this < 1180) ? 50 + (this - 680) / 10: 100;
  double admobWidth() => this - 100;
}

