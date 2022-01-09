import 'package:flutter/material.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'common_extension.dart';

Future<void> initPlugin() async {
  final status = await AppTrackingTransparency.trackingAuthorizationStatus;
  if (status == TrackingStatus.notDetermined) {
    await Future.delayed(const Duration(milliseconds: 200));
    await AppTrackingTransparency.requestTrackingAuthorization();
  }
}

Text appTitleText(String title) =>
    Text(title,
      style: const TextStyle(
        fontFamily: "cornerStone",
        fontSize: 28,
        color: Colors.white,
      ),
    );

Widget toiletImage(BuildContext context) =>
    Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.center,
          image: AssetImage("assets/images/toilet.jpg"),
          fit: BoxFit.fitHeight,
        ),
      ),
    );

Widget waterImage(BuildContext context, bool isWashing, int washStrength) =>
    Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Image(image: AssetImage(isWashing.waterImage(washStrength))),
    );

ButtonStyle circleButtonStyle(BuildContext context, Color color) {
  final width = MediaQuery.of(context).size.width;
  return ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
    shape: MaterialStateProperty.all<CircleBorder>(
      CircleBorder(
        side: BorderSide(color: color, width: width.circleBorderWidth()),
      ),
    ),
    minimumSize: MaterialStateProperty.all(Size.zero),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    shadowColor: MaterialStateProperty.all(Colors.transparent),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  );
}

ButtonStyle smallButtonStyle(BuildContext context, Color color) {
  final width = MediaQuery.of(context).size.width;
  return ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
    shape: MaterialStateProperty.all<CircleBorder>(
      CircleBorder(
        side: BorderSide(color: color, width: width.smallBorderWidth()),
      ),
    ),
    minimumSize: MaterialStateProperty.all(Size.zero),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    shadowColor: MaterialStateProperty.all(Colors.transparent),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  );
}


Text volumeText(BuildContext context, bool isPlus) {
  final width = MediaQuery.of(context).size.width;
  return Text(isPlus ? "＋": "−",
    style: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    textScaleFactor: width.plusMinusScaleFactor(),
  );
}

Widget volumeLamp(BuildContext context, int lampNumber, int volume, Color color) {
  final width = MediaQuery.of(context).size.width;
  return Container(
    width: width.lampSize(),
    height: width.lampSize(),
    padding: EdgeInsets.all(width.lampPadding()),
    child: ElevatedButton(
      style: circleColorStyle(
        (lampNumber == volume) ? color : Colors.black
      ),
      onPressed: () {},
      child: const Text(""),
    ),
  );
}

ButtonStyle circleColorStyle(Color backgroundColor) {
  return ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(5)),
    shape: MaterialStateProperty.all<CircleBorder>(
      const CircleBorder(side: BorderSide(color: Colors.black, width: 2)),
    ),
    minimumSize: MaterialStateProperty.all(Size.zero),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    shadowColor: MaterialStateProperty.all(Colors.transparent),
    backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
  );
}

ButtonStyle rectangleButtonStyle(BuildContext context) {
  return ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        side: BorderSide(
            color: Colors.grey,
            width: MediaQuery.of(context).size.width.plusMinusBorderWidth()
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    minimumSize: MaterialStateProperty.all(Size.zero),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    shadowColor: MaterialStateProperty.all(Colors.transparent),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  );
}