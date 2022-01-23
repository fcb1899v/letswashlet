import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'common_extension.dart';
import 'common_widget.dart';
import 'admob.dart';

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
  final String noneAudio = "audios/none.mp3";

  final int vibTime = 200;
  final int vibAmp = 128;
  final int prepWashTime = 4;
  final int musicTime = 20;
  final int flushTime = 11;
  final double prefWashVolume = 5;
  final double flushVolume = 9;

  final Color backWhite = Colors.white;
  final Color borderBlack = Colors.black54;
  final Color? deepOrange = Colors.deepOrange[400];
  final Color? lightOrange = Colors.deepOrange[100];
  final Color? deepBlue = Colors.blue[500];
  final Color? deepGreen = Colors.greenAccent[400];
  final Color? lightGreen = Colors.green[300];

  final AudioCache _washPlayer = AudioCache(fixedPlayer: AudioPlayer());
  final AudioCache _musicPlayer = AudioCache(fixedPlayer: AudioPlayer());
  final AudioCache _flushPlayer = AudioCache(fixedPlayer: AudioPlayer());

  late int washStrength;
  late int musicVolume;
  late bool isNozzle;
  late bool isWashing;
  late bool isListening;
  late bool isFlushing;
  late AudioPlayer? washAudioPlayer;
  late AudioPlayer? musicAudioPlayer;
  late AudioPlayer? flushAudioPlayer;
  late BannerAd myBanner;

  @override
  void initState() {
    "call initState".debugPrint();
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => initPlugin());
    setState(() {
      washStrength = 1;
      musicVolume = 1;
      isNozzle = false;
      isWashing = false;
      isListening = false;
      isFlushing = false;
      myBanner = AdmobService().getBannerAd();
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
  }

  @override
  void deactivate() {
    "call deactivate".debugPrint();
    super.deactivate();
  }

  @override
  void dispose() {
    "call dispose".debugPrint();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    "width: $width".debugPrint();
    "height: $height".debugPrint();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(width.appBarHeight()),
        child: AppBar(
          title: appTitleText(width, widget.title),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
      ),
      body: Container(color: Colors.white,
        child: Column(
          children: [
            const Spacer(flex: 3),
            Stack(children: [
              toiletImage(height),
              nozzleImage(height, isNozzle),
              waterImage(height, isWashing, washStrength),
            ]),
            const Spacer(flex: 1),
            Row(children: [
              const Spacer(flex: 2),
              Column(children: [
                SizedBox(height: width.circleBottomTopMargin()),
                Row(children: [
                  washStopButton(width),
                  washStartButton(width),
                ]),
                SizedBox(height: width.lampTopSpaceSize()),
                Row(children: [
                  washPlusMinusButton(width, false),
                  volumeLamp(width, 1, washStrength, deepGreen!),
                  volumeLamp(width, 2, washStrength, deepGreen!),
                  volumeLamp(width, 3, washStrength, deepGreen!),
                  volumeLamp(width, 4, washStrength, deepGreen!),
                  volumeLamp(width, 5, washStrength, deepGreen!),
                  washPlusMinusButton(width, true),
                ]),
              ]),
              const Spacer(flex: 1),
              Column(children: [
                flushButton(width),
                SizedBox(height: width.lampTopSpaceSize()),
                Row(children: [
                  musicStopButton(width),
                  musicPlayButton(width),
                ]),
                SizedBox(height: width.lampTopSpaceSize()),
                Row(children: [
                  musicPlusMinusButton(width, false),
                  volumeLamp(width, 1, musicVolume, deepGreen!),
                  volumeLamp(width, 2, musicVolume, deepGreen!),
                  volumeLamp(width, 3, musicVolume, deepGreen!),
                  musicPlusMinusButton(width, true),
                ]),
              ]),
              const Spacer(flex: 2),
            ]),
            const Spacer(flex: 3),
            adMobBannerWidget(width, height, myBanner),
          ],
        ),
      ),
    );
  }

  Widget washStartButton(double width) {
    return Container(
      width: width.circleButtonSize(),
      height: width.circleButtonSize(),
      padding: width.circleButtonPadding(),
      child: ElevatedButton(
        style: circleButtonStyle(width, backWhite, deepBlue!),
        child: Image(image: AssetImage(startWashImage)),
        onPressed: () => _startWashing(),
      ),
    );
  }

  void _startWashing() async {
    if (!isWashing) {
      Vibration.vibrate(duration: vibTime, amplitude: vibAmp);
      _washPlayer.play(prepWashAudio, volume: prefWashVolume);
      setState(() => isNozzle = true);
      await Future.delayed(Duration(seconds: prepWashTime)).then((_) async {
        setState(() => isWashing = true);
        washAudioPlayer = await _washPlayer.loop(washAudio, volume: washStrength.washVolume());
        "isWashing: $isWashing".debugPrint();
      });
    }
  }

  Widget washStopButton(double width) {
    return Container(
      width: width.circleButtonSize(),
      height: width.circleButtonSize(),
      padding: width.circleButtonPadding(),
      child: ElevatedButton(
        style: circleButtonStyle(width, lightOrange!, deepOrange!),
        child: Image(image: AssetImage(stopWashImage)),
        onPressed: () => _stopWashing(),
      ),
    );
  }

  void _stopWashing() {
    if (isWashing) {
      Vibration.vibrate(duration: vibTime, amplitude: vibAmp);
      washAudioPlayer?.stop();
      setState(() {
        isNozzle = false;
        isWashing = false;
      });
      _washPlayer.play(prepWashAudio, volume: prefWashVolume);
      "isWashing: $isWashing".debugPrint();
    }
  }

  Widget washPlusMinusButton(double width, bool isPlus) {
    return Container(
      width: width.rectangleButtonSize(),
      height: width.rectangleButtonSize(),
      padding: EdgeInsets.all(width.rectangleButtonPadding()),
      child: ElevatedButton(
        style: rectangleButtonStyle(width, backWhite, Colors.grey),
        child: volumeText(width, isPlus),
        onPressed: () => _washPlusMinus(isPlus),
      ),
    );
  }

  void _washPlusMinus(bool isPlus) {
    Vibration.vibrate(duration: vibTime, amplitude: vibAmp);
    setState(() => washStrength = isPlus.plusMinus(washStrength, 5, 1));
    washAudioPlayer?.setVolume(washStrength.washVolume());
    "washStrength: $washStrength".debugPrint();
  }

  Widget musicPlayButton(double width) {
    return Container(
      width: width.smallCircleSize(),
      height: width.smallCircleSize(),
      padding: width.smallCirclePadding(),
      child: ElevatedButton(
        style: smallCircleStyle(width, backWhite, lightGreen!),
        child: Image(image: AssetImage(musicImage)),
        onPressed: () => _playMusic(),
      ),
    );
  }

  void _playMusic() async {
    Vibration.vibrate(duration: vibTime, amplitude: vibAmp);
    musicAudioPlayer = await _musicPlayer.loop(musicAudio, volume: musicVolume.musicVolume());
    setState(() => isListening = true);
    "isListening: $isListening".debugPrint();
  }

  Widget musicStopButton(double width) {
    return Container(
      width: width.smallCircleSize(),
      height: width.smallCircleSize(),
      padding: width.smallCirclePadding(),
      child: ElevatedButton(
        style: smallCircleStyle(width, backWhite, borderBlack),
        child: Image(image: AssetImage(stopWashImage)),
        onPressed: () => _stopMusic(),
      ),
    );
  }

  void _stopMusic() {
    Vibration.vibrate(duration: vibTime, amplitude: vibAmp);
    musicAudioPlayer?.stop();
    setState(() => isListening = false);
    "isListening: $isListening".debugPrint();
  }

  Widget musicPlusMinusButton(double width, bool isPlus) {
    return Container(
      width: width.rectangleButtonSize(),
      height: width.rectangleButtonSize(),
      padding: EdgeInsets.all(width.rectangleButtonPadding()),
      child: ElevatedButton(
        style: rectangleButtonStyle(width, backWhite, Colors.grey),
        child: volumeText(width, isPlus),
        onPressed: () => _musicPlusMinus(isPlus),
      ),
    );
  }

  void _musicPlusMinus(bool isPlus) {
    Vibration.vibrate(duration: vibTime, amplitude: vibAmp);
    setState(() => musicVolume = isPlus.plusMinus(musicVolume, 3, 1));
    musicAudioPlayer?.setVolume(musicVolume.musicVolume());
    "washStrength: $musicVolume".debugPrint();
  }

  Widget flushButton(double width) {
    return Container(
      width: width.wideRectangleWidth(),
      height: width.wideRectangleHeight(),
      padding: width.smallCirclePadding(),
      child: ElevatedButton(
        style: wideRectangleStyle(width, backWhite, borderBlack),
        child: Image(image: AssetImage(flushImage)),
        onPressed: () => _startFlush(),
      ),
    );
  }

  void _startFlush() async {
    if (!isFlushing) {
      Vibration.vibrate(duration: vibTime, amplitude: vibAmp);
      flushAudioPlayer = await _flushPlayer.play(flushAudio, volume: flushVolume);
      setState(() => isFlushing = true);
      "isFlushing: $isFlushing".debugPrint();
      await Future.delayed(Duration(seconds: flushTime)).then((_) {
        flushAudioPlayer?.stop();
        setState(() => isFlushing = false);
        "isFlushing: $isFlushing".debugPrint();
      });
    }
  }
}