import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'common_extension.dart';

Text appTitleText(double width, String title) =>
    Text(title,
      style: const TextStyle(
        fontFamily: "cornerStone",
        fontSize: 30,
        color: Colors.white,
      ),
      textScaleFactor: width.titleScaleFactor(),
    );

Widget toiletImage(double height) =>
    Container(
      alignment: Alignment.center,
      height: height * 0.55,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/toilet.jpg"),
          fit: BoxFit.fitHeight,
        ),
      ),
    );

Widget nozzleImage(double height, bool isNozzle) =>
    Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: height * 0.31),
      child: AnimatedContainer(
        width: height * 0.01,
        height: height * isNozzle.nozzleLength(),
        duration: const Duration(seconds: 3),
        decoration: metalDecoration(),
      )
    );

Widget waterImage(double height, bool isWashing, int washStrength) =>
    Container(
      alignment: Alignment.center,
      height: height * 0.25,
      margin: EdgeInsets.only(top: height * 0.115),
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

ButtonStyle circleButtonStyle(double width, Color backgroundColor, Color borderColor) =>
    ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
      shape: MaterialStateProperty.all<CircleBorder>(width.circleButtonBorder(borderColor)),
      minimumSize: MaterialStateProperty.all(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
    );

ButtonStyle smallCircleStyle(double width, Color backgroundColor, Color borderColor) =>
    ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
      shape: MaterialStateProperty.all<CircleBorder>(width.smallCircleBorder(borderColor)),
      minimumSize: MaterialStateProperty.all(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
    );

Text volumeText(double width, bool isPlus) =>
    Text(isPlus ? "＋": "➖",
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
      textScaleFactor: width.rectangleScaleFactor(),
    );


Widget volumeLamp(double width, int lampNumber, int volume, Color? color) =>
    Container(
      width: width.lampSize(),
      height: width.lampSize(),
      padding: width.lampPadding(),
      child: TextButton(
        child: const Text(""),
        style: lampCircleStyle(lampNumber.lampColor(volume, color)),
        onPressed: () {},
      ),
    );


ButtonStyle lampCircleStyle(Color color) {
  const lampBorder = CircleBorder(side: BorderSide(color: Colors.black, width: 2));
  return ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(5)),
    shape: MaterialStateProperty.all<CircleBorder>(lampBorder),
    minimumSize: MaterialStateProperty.all(Size.zero),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    shadowColor: MaterialStateProperty.all(Colors.transparent),
    backgroundColor: MaterialStateProperty.all<Color>(color),
  );
}

ButtonStyle rectangleButtonStyle(double width, Color backgroundColor, Color borderColor) =>
    ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(color: borderColor, width: width.rectangleBorderWidth()),
          borderRadius: BorderRadius.circular(width.rectangleRadius()),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
    );

ButtonStyle wideRectangleStyle(double width, Color backgroundColor, Color borderColor) =>
    ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(color: borderColor, width: width.wideRectangleBorderWidth()),
          borderRadius: BorderRadius.circular(width.wideRectangleRadius()),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
    );


Widget adMobBannerWidget(double width, double height, BannerAd myBanner) =>
    SizedBox(
      width: width.admobWidth(),
      height: height.admobHeight(),
      child: AdWidget(ad: myBanner),
    );

