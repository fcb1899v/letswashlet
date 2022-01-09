import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'common_extension.dart';
import 'common_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //向き指定(縦固定)
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //MobileAds.instance.initialize();
  runApp(const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LETS WASHLET',
      theme: ThemeData(primarySwatch: Colors.grey),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'LETS WASHLET'),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final String stopWashImage = "assets/images/black.png";
  final String startWashImage = "assets/images/wash.png";
  final String musicImage = "assets/images/music.png";
  final String flushImage = "assets/images/flush.png";

  final String washAudio = "audios/wash.mp3";
  final String prepWashAudio = "audios/prepWash.m4a";
  final String musicAudio = "audios/river.mp3";
  final String flushAudio = "audios/flush.mp3";

  final int vibTime = 200;
  final int vibAmp = 128;
  final int prepWashTime = 3;
  final int musicTime = 11;
  final int flushTime = 11;

  final Color? orangeColor = Colors.deepOrange[400];
  final Color? blueColor = Colors.blue[500];
  final Color? pinkColor = Colors.pinkAccent[100];
  final Color? greenColor = Colors.greenAccent[400];

  final AudioCache _washPlayer = AudioCache(fixedPlayer: AudioPlayer());
  final AudioCache _musicPlayer = AudioCache(fixedPlayer: AudioPlayer());
  final AudioCache _flushPlayer = AudioCache(fixedPlayer: AudioPlayer());

  late int washStrength;
  late bool isWashing;
  late bool isListening;
  late bool isFlushing;
  late AudioPlayer? washAudioPlayer;
  late AudioPlayer? musicAudioPlayer;
  late AudioPlayer? flushAudioPlayer;

  @override
  void initState() {
    "call initState".debugPrint();
    super.initState();
    setState(() {
      washStrength = 1;
      isWashing = false;
      isListening = false;
      isFlushing = false;
    });
  }

  @override
  void didChangeDependencies() {
    "call didChangeDependencies".debugPrint();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(oldWidget) {
    "call didUpdateWidget".debugPrint();
    super.didUpdateWidget(oldWidget);
    if (washAudioPlayer != null) washAudioPlayer!.stop();
    if (musicAudioPlayer != null) musicAudioPlayer!.stop();
    if (flushAudioPlayer != null) flushAudioPlayer!.stop();
  }

  @override
  void deactivate() {
    "call deactivate".debugPrint();
    super.deactivate();
    if (washAudioPlayer != null) washAudioPlayer!.stop();
    if (musicAudioPlayer != null) musicAudioPlayer!.stop();
    if (flushAudioPlayer != null) flushAudioPlayer!.stop();
  }

  @override
  void dispose() {
    "call dispose".debugPrint();
    super.dispose();
    if (washAudioPlayer != null) washAudioPlayer!.stop();
    if (musicAudioPlayer != null) musicAudioPlayer!.stop();
    if (flushAudioPlayer != null) flushAudioPlayer!.stop();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: appTitleText(widget.title),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const Spacer(flex: 1),
            Stack(
              children: [
                toiletImage(context),
                waterImage(context, isWashing, washStrength),
              ],
            ),
            Row(
              children: [
                const Spacer(flex: 2),
                Column(
                  children: [
                    Row(
                      children: [
                        washStopButton(),
                        washStartButton(),
                      ]
                    ),
                    SizedBox(height: width.plusMinusMarginSize()),
                    Row(
                      children: [
                        washPlusMinusButton(false),
                        volumeLamp(context, 1, washStrength, greenColor!),
                        volumeLamp(context, 2, washStrength, greenColor!),
                        volumeLamp(context, 3, washStrength, greenColor!),
                        volumeLamp(context, 4, washStrength, greenColor!),
                        volumeLamp(context, 5, washStrength, greenColor!),
                        washPlusMinusButton(true),
                      ],
                    )
                  ]
                ),
                const Spacer(flex: 1),
                Column(
                  children: [
                    musicButton(),
                    flushButton(),
                  ],
                ),
                const Spacer(flex: 2),
              ],
            ),
            const Spacer(flex: 5),
          ],
        ),
      ),
    );
  }

  Widget washStartButton() {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width.circleButtonSize(),
      height: width.circleButtonSize(),
      padding: EdgeInsets.all(width.circleButtonPadding()),
      child: ElevatedButton(
        style: circleButtonStyle(context, blueColor!),
        child: Image(image: AssetImage(startWashImage)),
        onPressed: () {
          Vibration.vibrate(duration: vibTime, amplitude: vibAmp);
          _startWashing();
        },
      ),
    );
  }

  void _startWashing() async {
    if (!isWashing) {
      _washPlayer.play(prepWashAudio);
      await Future.delayed(Duration(seconds: prepWashTime)).then((_) async {
        setState(() => isWashing = true);
        washAudioPlayer = await _washPlayer.loop(washAudio);
        "isWashing: $isWashing".debugPrint();
      });
    }
  }

  Widget washStopButton() {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width.circleButtonSize(),
      height: width.circleButtonSize(),
      padding: EdgeInsets.all(width.circleButtonPadding()),
      child: ElevatedButton(
        style: circleButtonStyle(context, orangeColor!),
        child: Image(image: AssetImage(stopWashImage)),
        onPressed: () {
          Vibration.vibrate(duration: vibTime, amplitude: vibAmp);
          _stopWashing();
        },
      ),
    );
  }

  void _stopWashing() {
    if (isWashing) {
      if (washAudioPlayer != null) washAudioPlayer!.stop();
      setState(() => isWashing = false);
      _washPlayer.play(prepWashAudio);
      "isWashing: $isWashing".debugPrint();
    }
  }

  Widget washPlusMinusButton(bool isPlus) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width.plusMinusButtonSize(),
      height: width.plusMinusButtonSize(),
      padding: EdgeInsets.all(width.plusMinusButtonPadding()),
      child: ElevatedButton(
        style: rectangleButtonStyle(context),
        child: volumeText(context, isPlus),
        onPressed: () {
          Vibration.vibrate(duration: vibTime, amplitude: vibAmp);
          setState(() => washStrength = isPlus.plusMinus(washStrength, 5, 1));
          "washStrength: $washStrength".debugPrint();
        },
      ),
    );
  }

  Widget musicButton() {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width.smallButtonSize(),
      height: width.smallButtonSize(),
      margin: EdgeInsets.only(
        top: width.smallButtonMarginTop(),
        bottom: width.smallButtonMarginBottom(),
      ),
      padding: EdgeInsets.all(width.smallButtonPadding()),
      child: ElevatedButton(
        style: smallButtonStyle(context, pinkColor!),
        child: Image(image: AssetImage(musicImage)),
        onPressed: () async {
          Vibration.vibrate(duration: vibTime, amplitude: vibAmp);
          (!isListening) ? _playMusic(): _stopMusic();
        },
      ),
    );
  }

  void _playMusic() async {
    musicAudioPlayer = await _musicPlayer.play(musicAudio);
    setState(() => isListening = true);
    "isListening: $isListening".debugPrint();
    await Future.delayed(Duration(seconds: musicTime)).then((_) =>_stopMusic());
  }

  void _stopMusic() {
    if (isListening) {
      if (musicAudioPlayer != null) musicAudioPlayer!.stop();
      setState(() => isListening = false);
      "isListening: $isListening".debugPrint();
    }
  }

  Widget flushButton() {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width.smallButtonSize(),
      height: width.smallButtonSize(),
      margin: EdgeInsets.only(
        top: width.smallButtonMarginTop(),
        bottom: width.smallButtonMarginBottom(),
      ),
      padding: EdgeInsets.all(width.smallButtonPadding()),
      child: ElevatedButton(
        style: smallButtonStyle(context, greenColor!),
        child: Image(image: AssetImage(flushImage)),
        onPressed: () async {
          Vibration.vibrate(duration: vibTime, amplitude: vibAmp);
          if (!isFlushing) _startFlush();
        },
      ),
    );
  }

  void _startFlush() async {
    flushAudioPlayer = await _flushPlayer.play(flushAudio);
    setState(() => isFlushing = true);
    "isFlushing: $isFlushing".debugPrint();
    await Future.delayed(Duration(seconds: flushTime)).then((_) {
      if (flushAudioPlayer != null) flushAudioPlayer!.stop();
      setState(() => isFlushing = false);
      "isFlushing: $isFlushing".debugPrint();
    });
  }
}
