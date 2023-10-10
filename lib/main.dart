import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:clash_api/screens/list_clash_cards.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playMusic();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  Future<void> _playMusic() async {
    AssetsAudioPlayer.newPlayer().open(
      Audio('assets/loading.mp3'),
      autoStart: true,
    );
    /*
    audioPlayer.play(
        'https://vgmsite.com/soundtracks/clash-royale-original-game-soundtrack/afzbmphjha/Scroll%20Loading%2001.mp3');
    */
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListClashCard(),
    );
  }
}
