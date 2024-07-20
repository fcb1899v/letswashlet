import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'extension.dart';
import 'constant.dart';

/// App Tracking Transparency
Future<void> initATTPlugin(BuildContext context) async {
  final status = await AppTrackingTransparency.trackingAuthorizationStatus;
  if (status == TrackingStatus.notDetermined && context.mounted) {
    await showCupertinoDialog(context: context, builder: (context) => CupertinoAlertDialog(
      title: Text(AppLocalizations.of(context)!.appTitle),
      content: Text(AppLocalizations.of(context)!.thisApp),
      actions: [
        CupertinoDialogAction(
          child: const Text('OK', style: TextStyle(color: Colors.blue)),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ));
    await Future.delayed(const Duration(milliseconds: 200));
    await AppTrackingTransparency.requestTrackingAuthorization();
  }
}

/// App Bar
AppBar myHomeAppBar(BuildContext context) =>
    AppBar(
      title: Text(title,
        style: const TextStyle(
          fontFamily: "cornerStone",
          fontSize: appBarFontSize,
          color: whiteColor,
        ),
        textScaler: TextScaler.linear(context.titleScaleFactor()),
      ),
      centerTitle: true,
      backgroundColor: blackColor,
    );


/// Toilet Image
Widget toiletImage(BuildContext context) =>
    Container(
      alignment: Alignment.center,
      height: context.height() * toiletImageHeightRate,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(toiletJpgImage),
          fit: BoxFit.fitHeight,
        ),
      ),
    );

Widget nozzleImage(BuildContext context, bool isNozzle) =>
    Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: context.height() * nozzleTopPaddingRate),
      child: AnimatedContainer(
        width: context.height() * nozzleWidthRate,
        height: context.height() * isNozzle.nozzleLength(),
        duration: const Duration(seconds: nozzleMovingTime),
        decoration: metalDecoration(),
      )
    );

Widget waterImage(BuildContext context, bool isWashing, int washStrength) =>
    Container(
      alignment: Alignment.center,
      height: context.height() * waterImageHeightRate,
      margin: EdgeInsets.only(top: context.height() * waterTopMarginRate),
      child: Image(image: AssetImage(isWashing.waterImage(washStrength))),
    );

BoxDecoration metalDecoration() =>
    const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0, 0.4, 0.7, 0.8, 0.9],
        colors: [
          Colors.white70,
          Colors.white38,
          Colors.white12,
          Colors.black45,
          Colors.white38,
        ],
      )
    );

///Wash Button Image
Widget washButtonImage(BuildContext context, bool isStart) =>
    Container(
      width: context.washButtonSize(),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isStart ? whiteColor: lightOrange!,
        border: Border.all(
          color: isStart ? deepBlue!: deepOrange!,
          width: context.thickBorderWidth(),
        ),
      ),
      child: Image(
        image: AssetImage(isStart ? startWashImage: stopWashImage)
      ),
    );

///Music Button Image
Widget musicButtonImage(BuildContext context, bool isPlay) =>
    Container(
      width: context.musicButtonSize(),
      height: context.musicButtonSize(),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: whiteColor,
        border: Border.all(
          color: isPlay ? lightGreen!: borderBlack,
          width: context.thinBorderWidth(),
        ),
      ),
      child: Image(
        image: AssetImage(isPlay ? musicImage: stopWashImage)
      ),
    );

/// Volume Button Image
Widget volumeButtonImage(BuildContext context, bool isPlus) =>
    Container(
      width: context.volumeButtonSize(),
      height: context.volumeButtonSize(),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: whiteColor,
        border: Border.all(
          color: greyColor,
          width: context.thinBorderWidth(),
        ),
        borderRadius: BorderRadius.circular(context.buttonRadius()),
      ),
      child: Text(isPlus ? "+": "–",
        style: TextStyle(
          color: blackColor,
          fontSize: context.volumeFontSize(),
          fontFamily: "roboto"
        ),
        textAlign: TextAlign.center,
        textScaler: TextScaler.linear(context.volumeScaleFactor()),
      ),
    );

///Flush Button Image
Widget flushButtonImage(BuildContext context) =>
    Container(
      width: context.flushButtonWidth(),
      height: context.flushButtonHeight(),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: whiteColor,
        border: Border.all(
          color: borderBlack,
          width: context.thinBorderWidth(),
        ),
        borderRadius: BorderRadius.circular(context.buttonRadius()),
      ),
      child: const Image(image: AssetImage(flushImage)),
    );

///Volume Lump Image
Widget volumeLamp(BuildContext context, int lampNumber, int volume) =>
    Container(
      width: context.lampSize(),
      height: context.lampSize(),
      margin: EdgeInsets.symmetric(horizontal: context.lampSpace()),
      padding: EdgeInsets.all(context.lampPadding()),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: blackColor,
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: lampNumber.lampColor(volume, deepGreen),
        ),
      ),
    );

