import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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
      (this) ? "assets/images/w$strength.gif":
      "assets/images/transparent.png";

  int plusMinus(int strength, int max, int min) =>
      (this && strength < max) ? strength + 1:
      (!this && strength > min) ? strength - 1: strength;

  double nozzleLength() =>
      (this) ? 0.04: 0;
}

extension DoubleExt on double {

  //App Bar
  double appBarHeight() => (this < 660) ? (this - 60) / 10 + 20: 80;
  double titleScaleFactor() => (this < 510) ? (this - 60) / 300: 1.5;

  //Wash Start & Stop Button
  double circleButtonSize() => (this < 660) ? (this - 60) / 3: 200.0;
  double circlePaddingSize() => (this < 660) ? (this - 60) / 60: 10.0;
  EdgeInsets circleButtonPadding() => EdgeInsets.all(circlePaddingSize());
  double circleBorderSize() => (this < 660) ? (this - 60) / 60: 10.0;
  CircleBorder circleButtonBorder(Color color) =>
      CircleBorder(side: BorderSide(color: color, width: circleBorderSize()));
  double circleBottomTopMargin() => (this < 660) ? (this - 60) / 30: 20;

  //Music Play & Stop Button
  double smallCircleSize() => (this < 660) ? (this - 60) / 5: 120.0;
  double smallCirclePaddingSize() => (this < 660) ? (this - 60) / 60: 10.0;
  EdgeInsets smallCirclePadding() => EdgeInsets.all(smallCirclePaddingSize());
  double smallCircleBorderWidth() => (this < 660) ? (this - 60) / 100: 6.0;
  CircleBorder smallCircleBorder(Color color) =>
      CircleBorder(side: BorderSide(color: color, width: smallCircleBorderWidth()));

  //Plus Minus Button
  double rectangleButtonSize() => (this < 660) ? (this - 60) / 7.5: 80.0;
  double rectangleButtonPadding() => (this < 600) ? (this - 60) / 120: 5.0;
  double rectangleScaleFactor() => (this < 660) ? (this - 60) / 300: 2.0;
  double rectangleBorderWidth() => (this < 660) ? (this - 60) / 120: 5.0;
  double rectangleRadius() => (this < 600) ? (this - 60) / 50: 12.0;

  //Flush Button
  double wideRectangleWidth() => (this < 660) ? (this - 60) / 2.5: 240.0;
  double wideRectangleHeight() => (this < 660) ? (this - 30) / 7: 90.0;
  double wideRectangleBorderWidth() => (this < 660) ? (this - 60) / 100: 6.0;
  double wideRectangleRadius() => (this < 600) ? (this - 60) / 40: 15.0;

  //Lamp
  double lampSize() => (this < 660) ? (this - 60) / 25 + 4: 28.0;
  EdgeInsets lampPadding() =>
      EdgeInsets.all((this < 660) ? (this - 60) / 120: 5.0);
  double lampTopSpaceSize() => (this < 660) ? (this - 60) / 100: 6.0;

  //Admob
  double admobHeight() => (this < 680) ? 50: (this < 1180) ? 50 + (this - 680) / 10: 100;
  double admobWidth() => this - 100;

}

