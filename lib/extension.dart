import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'constant.dart';

extension ContextExt on BuildContext {
  ///Common
  double width() => MediaQuery.of(this).size.width;
  double height() => MediaQuery.of(this).size.height;

  ///AppBar Size
  double appBarHeight() => (width() < 660) ? (width() - 60) / 10 + 20: 80;
  double titleScaleFactor() => (width() < 510) ? (width() - 60) / 300: 1.5;

  ///Button Size
  double washButtonSize() => (width() < 660) ? (width() - 60) / 3 - 20: 180.0;
  double musicButtonSize() => (width() < 660) ? (width() - 60) / 6: 100.0;
  double volumeButtonSize() => (width() < 660) ? (width() - 60) / 10: 60.0;
  double volumeScaleFactor() => (width() < 660) ? (width() - 60) / 300: 2.0;
  double volumeFontSize() => (width() < 660) ? (width() - 60) / 20: 30.0;
  double flushButtonWidth() => (width() < 660) ? (width() - 60) / 3: 200.0;
  double flushButtonHeight() => (width() < 660) ? (width() - 60) / 8: 90.0;
  double thickBorderWidth() => (width() < 660) ? (width() - 60) / 60: 10.0;
  double thinBorderWidth() => (width() < 660) ? (width() - 60) / 100: 6.0;
  double buttonRadius() => (width() < 660) ? (width() - 60) / 40: 15.0;
  double buttonSpace() => (width() < 660) ? (width() - 60) / 25: 24.0;

  ///Lamp Size
  double lampSize() => (width() < 660) ? (width() - 60) / 25: 24.0;
  double lampPadding() => (width() < 660) ? (width() - 60) / 150: 4.0;
  double lampSpace() => (width() < 660) ? (width() - 60) / 240: 2.5;
  double lampSideSpace() => (width() < 660) ? (width() - 60) / 48: 12.5;

  ///Admob
  double admobHeight() => (height() < 600) ? 50: (height() < 1000) ? 50 + (height() - 600) / 8: 100;
  double admobWidth() => width() - 100;
}

extension StringExt on String {

  void debugPrint() {
    if (kDebugMode) {
      print(this);
    }
  }

  ///Audio Player
  void playAudio(AudioPlayer audioPlayer) async {
    debugPrint();
    await audioPlayer.setReleaseMode(ReleaseMode.stop);
    await audioPlayer.stop();
    await audioPlayer.setReleaseMode(ReleaseMode.release);
    await audioPlayer.play(AssetSource(this));
  }

  void loopAudio(AudioPlayer audioPlayer) async {
    debugPrint();
    await audioPlayer.setReleaseMode(ReleaseMode.stop);
    await audioPlayer.stop();
    await audioPlayer.setReleaseMode(ReleaseMode.loop);
    await audioPlayer.play(AssetSource(this));
  }

}

extension IntExt on int {

  double washingVolume() => 1.5 * this;
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