import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'extension.dart';
import 'constant.dart';

Future<void> initPlugin(BuildContext context) async {
  final status = await AppTrackingTransparency.trackingAuthorizationStatus;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final iosInfo = await deviceInfo.iosInfo;
  final iosOsVersion = iosInfo.systemVersion!;
  if (status == TrackingStatus.notDetermined) {
    if (double.parse(iosOsVersion) >= 15) {
      "iOS${double.parse(iosOsVersion)}".debugPrint();
      await showCupertinoDialog(context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(AppLocalizations.of(context)!.appTitle),
              content: Text(AppLocalizations.of(context)!.thisApp),
              actions: [
                CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            );
          }
      );
    }
    await Future.delayed(const Duration(milliseconds: 200));
    await AppTrackingTransparency.requestTrackingAuthorization();
  }
}

AppBar myHomeAppBar(double width) =>
    AppBar(
      title: Text(title,
        style: const TextStyle(
          fontFamily: "cornerStone",
          fontSize: 30,
          color: whiteColor,
        ),
        textScaleFactor: width.titleScaleFactor(),
      ),
      centerTitle: true,
      backgroundColor: blackColor,
    );


/// Toilet Image
Widget toiletImage(double height) =>
    Container(
      alignment: Alignment.center,
      height: height * toiletImageHeightRate,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(toiletJpgImage),
          fit: BoxFit.fitHeight,
        ),
      ),
    );

Widget nozzleImage(double height, bool isNozzle) =>
    Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: height * nozzleTopPaddingRate),
      child: AnimatedContainer(
        width: height * nozzleWidthRate,
        height: height * isNozzle.nozzleLength(),
        duration: const Duration(seconds: nozzleMovingTime),
        decoration: metalDecoration(),
      )
    );

Widget waterImage(double height, bool isWashing, int washStrength) =>
    Container(
      alignment: Alignment.center,
      height: height * waterImageHeightRate,
      margin: EdgeInsets.only(top: height * waterTopMarginRate),
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

/// Wash Widget
Widget washButtonImage(double width, bool isStart) =>
    SizedBox(
      width: width.washButtonSize(),
      child: Image(image: AssetImage(
        isStart ? startWashImage: stopWashImage,
      )),
    );

ButtonStyle washButtonStyle(double width, bool isStart) =>
    ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
      shape: MaterialStateProperty.all<CircleBorder>(CircleBorder(side: BorderSide(
        color: isStart ? deepBlue!: deepOrange!,
        width: width.thickBorderWidth(),
      ))),
      minimumSize: MaterialStateProperty.all(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      backgroundColor: MaterialStateProperty.all<Color>(isStart ? whiteColor: lightOrange!),
    );


/// Music Widget
Widget musicButtonImage(double width, bool isPlay) =>
    SizedBox(
      width: width.musicButtonSize(),
      height: width.musicButtonSize(),
      child: Image(image: AssetImage(isPlay ? musicImage: stopWashImage)),
    );

ButtonStyle musicButtonStyle(double width, bool isPlay) =>
    ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
      shape: MaterialStateProperty.all<CircleBorder>(CircleBorder(side: BorderSide(
        color: isPlay ? lightGreen!: borderBlack,
        width: width.thinBorderWidth()
      ))),
      minimumSize: MaterialStateProperty.all(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      backgroundColor: MaterialStateProperty.all<Color>(whiteColor),
    );

/// Volume Widget
Widget volumeButtonImage(double width, bool isPlus) =>
    SizedBox(
      width: width.volumeButtonSize(),
      height: width.volumeButtonSize(),
      child: Column(children: [
        Text(isPlus ? "+": "-",
          style: const TextStyle(color: blackColor, fontSize: 26.0),
          textScaleFactor: width.volumeScaleFactor(),
        ),
      ])
    );

ButtonStyle volumeButtonStyle(double width) =>
    ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(
            color: greyColor,
            width: width.thinBorderWidth(),
          ),
          borderRadius: BorderRadius.circular(width.buttonRadius()),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      backgroundColor: MaterialStateProperty.all<Color>(whiteColor),
    );

Widget volumeLamp(double width, int lampNumber, int volume, Color? color) =>
    Container(
      width: width.lampSize(),
      height: width.lampSize(),
      padding: EdgeInsets.all(width.lampPadding()),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: blackColor,
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: lampNumber.lampColor(volume, color),
        ),
      ),
    );

///Flush Widget
Widget flushButtonImage(double width) =>
    SizedBox(
      width: width.flushButtonWidth(),
      height: width.flushButtonHeight(),
      child: const Image(image: AssetImage(flushImage)),
    );

ButtonStyle flushButtonStyle(double width) =>
    ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(
            color: borderBlack,
            width: width.thinBorderWidth(),
          ),
          borderRadius: BorderRadius.circular(width.buttonRadius()),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      backgroundColor: MaterialStateProperty.all<Color>(whiteColor),
    );

///Admob Banner
Widget adMobBannerWidget(double width, double height, BannerAd myBanner) =>
    SizedBox(
      width: width.admobWidth(),
      height: height.admobHeight(),
      child: AdWidget(ad: myBanner),
    );

