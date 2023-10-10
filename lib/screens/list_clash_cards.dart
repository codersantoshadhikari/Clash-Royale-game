import 'dart:ui';
import 'loading_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/clash_card_item.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:clash_api/network/api_clash.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:clash_api/models/card_clash_model.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ListClashCard extends StatefulWidget {
  const ListClashCard({super.key});

  @override
  State<ListClashCard> createState() => _ListClashCardState();
}

class _ListClashCardState extends State<ListClashCard> {
  // Crea una instancia del reproductor de audio
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer audioPlayeraux = AudioPlayer();
  ApiClash? apiClash;

  // Reproduce la música al entrar a la vista
  Future<void> _playMusic() async {
    Future.delayed(const Duration(seconds: 5)).then((_) {
      audioPlayeraux.play(
          'https://vgmsite.com/soundtracks/clash-royale-original-game-soundtrack/tjtkvfrnys/Menu%2003.mp3');
    });
    audioPlayeraux.onPlayerCompletion.listen((event) {
      _playMusic();
    });
  }

  // Detiene la música al salir de la vista
  Future<void> _stopMusic() async {
    await audioPlayer.stop();
    await audioPlayeraux.stop();
  }

  @override
  void initState() {
    super.initState();
    apiClash = ApiClash();
    _stopMusic();
    _playMusic();
  }

  @override
  void dispose() {
    _stopMusic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: apiClash!.getAllCards(),
          builder: (context, AsyncSnapshot<List<ClashCard>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingScreen(future: apiClash!.getAllCards());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Ocurrió un error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.black87,
                  elevation: 0,
                  title:
                      const Text('CLASH ROYALE API').animate().fade(duration: 400.ms),
                  centerTitle: true,
                ),
                body: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              'https://i.pinimg.com/originals/3b/ec/9a/3bec9a888fd77bb74349d7e6b02c32e8.jpg'),
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ItemClashCard(card: snapshot.data![index]);
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
    );
  }
}
