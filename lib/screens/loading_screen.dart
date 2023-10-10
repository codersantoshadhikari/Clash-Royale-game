import 'dart:async';
import 'package:flutter/material.dart';
import 'package:clash_api/models/card_clash_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatefulWidget {
  final Future<List<ClashCard>?> future;

  const LoadingScreen({Key? key, required this.future}) : super(key: key);

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  late final Timer _timer;
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1000), (timer) {
      setState(() {
        _progressValue += 0.01;
      });
      if (_progressValue >= 1.0) {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/loading_background.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.blueGrey,
                  size: 60.0,
                ),
                const SizedBox(height: 12.0),
                const Text(
                  'loading',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
