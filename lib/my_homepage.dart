import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'extension.dart';
import 'common_widget.dart';
import 'admob.dart';
import 'constant.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
  late double width;
  late double height;

  @override
  void initState() {
    "call initState".debugPrint();
    super.initState();
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
    WidgetsBinding.instance.addPostFrameCallback((_) => initPlugin(context));
    setState((){
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height;
    });
    "width: $width, height: $height".debugPrint();
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
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(width.appBarHeight()),
          child: myHomeAppBar(width),
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
                  washButtons(),
                  SizedBox(height: width.buttonSpace()),
                  washVolumeButtons(),
                ]),
                const Spacer(flex: 1),
                Column(children: [
                  flushButton(),
                  SizedBox(height: width.buttonSpace()),
                  musicButtons(),
                  SizedBox(height: width.buttonSpace()),
                  musicVolumeButtons(),
                ]),
                const Spacer(flex: 2),
              ]),
              const Spacer(flex: 3),
              adMobBannerWidget(width, height, myBanner),
            ],
          ),
        ),
      );

  ///Wash Widget
  Widget washButtons() =>
      Row(children: [
        ElevatedButton(
          style: washButtonStyle(width, false),
          child: washButtonImage(width, false),
          onPressed: () => _stopWashing(),
        ),
        SizedBox(width: width.buttonSpace()),
        ElevatedButton(
          style: washButtonStyle(width, true),
          child: washButtonImage(width, true),
          onPressed: () => _startWashing(),
        ),
      ]);

  ///Wash Volume Widget
  Widget washVolumeButtons() =>
      Row(children: [
        ElevatedButton(
          style: volumeButtonStyle(width),
          child: volumeButtonImage(width, false),
          onPressed: () => _washPlusMinus(false),
        ),
        SizedBox(width: width.lampSideSpace()),
        volumeLamp(width, 1, washStrength, deepGreen!),
        SizedBox(width: width.lampSpace()),
        volumeLamp(width, 2, washStrength, deepGreen!),
        SizedBox(width: width.lampSpace()),
        volumeLamp(width, 3, washStrength, deepGreen!),
        SizedBox(width: width.lampSpace()),
        volumeLamp(width, 4, washStrength, deepGreen!),
        SizedBox(width: width.lampSpace()),
        volumeLamp(width, 5, washStrength, deepGreen!),
        SizedBox(width: width.lampSideSpace()),
        ElevatedButton(
          style: volumeButtonStyle(width),
          child: volumeButtonImage(width, true),
          onPressed: () => _washPlusMinus(true),
        ),
      ]);

  ///Music Widget
  Widget musicButtons() =>
      Row(children: [
        ElevatedButton(
          style: musicButtonStyle(width, false),
          child: musicButtonImage(width, false),
          onPressed: () => _stopMusic(),
        ),
        SizedBox(width: width.buttonSpace()),
        ElevatedButton(
          style: musicButtonStyle(width, true),
          child: musicButtonImage(width, true),
          onPressed: () => _playMusic(),
        ),
      ]);

  ///Music Volume Widget
  Widget musicVolumeButtons() =>
      Row(children: [
        ElevatedButton(
          style: volumeButtonStyle(width),
          child: volumeButtonImage(width, false),
          onPressed: () => _musicPlusMinus(false),
        ),
        SizedBox(width: width.lampSideSpace()),
        volumeLamp(width, 1, musicVolume, deepGreen!),
        SizedBox(width: width.lampSpace()),
        volumeLamp(width, 2, musicVolume, deepGreen!),
        SizedBox(width: width.lampSpace()),
        volumeLamp(width, 3, musicVolume, deepGreen!),
        SizedBox(width: width.lampSideSpace()),
        ElevatedButton(
          style: volumeButtonStyle(width),
          child: volumeButtonImage(width, true),
          onPressed: () => _musicPlusMinus(true),
        ),
      ]);

  ///Flush Widget
  Widget flushButton() =>
      ElevatedButton(
        style: flushButtonStyle(width),
        child: flushButtonImage(width),
        onPressed: () => _startFlush(),
      );

  ///Wash Action
  _startWashing() async {
    if (!isWashing) {
      Vibration.vibrate(duration: vibTime, amplitude: vibAmp);
      _washPlayer.play(prepWashAudio, volume: prefWashVolume);
      setState(() => isNozzle = true);
      await Future.delayed(const Duration(seconds: prepWashTime)).then((_) async {
        setState(() => isWashing = true);
        washAudioPlayer = await _washPlayer.loop(washAudio, volume: washStrength.washVolume());
        "isWashing: $isWashing".debugPrint();
      });
    }
  }

  _stopWashing() {
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

  _washPlusMinus(bool isPlus) {
    Vibration.vibrate(duration: vibTime, amplitude: vibAmp);
    setState(() => washStrength = isPlus.plusMinus(washStrength, 5, 1));
    washAudioPlayer?.setVolume(washStrength.washVolume());
    "washStrength: $washStrength".debugPrint();
  }

  ///Music Action
  _playMusic() async {
    Vibration.vibrate(duration: vibTime, amplitude: vibAmp);
    musicAudioPlayer = await _musicPlayer.loop(musicAudio, volume: musicVolume.musicVolume());
    setState(() => isListening = true);
    "isListening: $isListening".debugPrint();
  }

  _stopMusic() {
    Vibration.vibrate(duration: vibTime, amplitude: vibAmp);
    musicAudioPlayer?.stop();
    setState(() => isListening = false);
    "isListening: $isListening".debugPrint();
  }

  _musicPlusMinus(bool isPlus) {
    Vibration.vibrate(duration: vibTime, amplitude: vibAmp);
    setState(() => musicVolume = isPlus.plusMinus(musicVolume, 3, 1));
    musicAudioPlayer?.setVolume(musicVolume.musicVolume());
    "washStrength: $musicVolume".debugPrint();
  }

  ///Flush Action
  _startFlush() async {
    if (!isFlushing) {
      Vibration.vibrate(duration: vibTime, amplitude: vibAmp);
      flushAudioPlayer = await _flushPlayer.play(flushAudio, volume: flushVolume);
      setState(() => isFlushing = true);
      "isFlushing: $isFlushing".debugPrint();
      await Future.delayed(const Duration(seconds: flushTime)).then((_) {
        flushAudioPlayer?.stop();
        setState(() => isFlushing = false);
        "isFlushing: $isFlushing".debugPrint();
      });
    }
  }
}