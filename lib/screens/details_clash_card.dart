import 'dart:ui';
import '../responsive.dart';
import 'package:flutter/material.dart';
import '../widgets/fadein_widget.dart';
import '../models/card_clash_model.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CardClashDetailsScreen extends StatefulWidget {
  final ClashCard card;

  const CardClashDetailsScreen({super.key, required this.card});

  @override
  State<CardClashDetailsScreen> createState() => _CardClashDetailsScreenState();
}

class _CardClashDetailsScreenState extends State<CardClashDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.card.name ?? '').animate().fade(duration: 100.ms),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(widget.card.iconUrls ?? ''),
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          Responsive(
            mobile: _buildMobileConten(context),
            tablet: _buildTabletContent(context),
            desktop: _buildTabletContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileConten(BuildContext context) {
    return Center(
      child: Hero(
        tag: 'card_${widget.card.id}',
        child: FadeIn(
          child: Card(
            elevation: 8,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 96),
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 12 / 8,
                    child: InteractiveViewer(
                      child: CachedNetworkImage(
                        imageUrl: widget.card.iconUrls ?? '',
                        placeholder: (context, url) => Center(
                          child: LoadingAnimationWidget.dotsTriangle(
                            color: Colors.blueAccent,
                            size: 30,
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Animate(
                        delay: 400.ms,
                        effects: [
                          FadeEffect(duration: 2000.ms),
                        ],
                        child: Text(widget.card.name ?? '')),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.confirmation_number),
                    title: const Text(
                      'ID',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Animate(
                        delay: 500.ms,
                        effects: [
                          FadeEffect(duration: 2000.ms),
                        ],
                        child: Text(widget.card.id.toString())),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.arrow_upward),
                    title: const Text(
                      'Max Level',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Animate(
                        delay: 600.ms,
                        effects: [
                          FadeEffect(duration: 2000.ms),
                        ],
                        child: Text(widget.card.maxLevel.toString())),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabletContent(BuildContext context){
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Card(
            elevation: 8,
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 12 / 8,
                    child: InteractiveViewer(
                      child: CachedNetworkImage(
                        imageUrl: widget.card.iconUrls ?? '',
                        placeholder: (context, url) => Center(
                          child: LoadingAnimationWidget.dotsTriangle(
                            color: Colors.blueAccent,
                            size: 30,
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  )
                ]
              )
            )
          ),
        ),
        Expanded(
          flex:2,
          child: Card(
            elevation: 8,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text(
                          'Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Animate(
                            delay: 400.ms,
                            effects: [
                              FadeEffect(duration: 2000.ms),
                            ],
                            child: Text(widget.card.name ?? '')),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.confirmation_number),
                        title: const Text(
                          'ID',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Animate(
                            delay: 500.ms,
                            effects: [
                              FadeEffect(duration: 2000.ms),
                            ],
                            child: Text(widget.card.id.toString())),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.arrow_upward),
                        title: const Text(
                          'Max Level',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Animate(
                            delay: 600.ms,
                            effects: [
                              FadeEffect(duration: 2000.ms),
                            ],
                            child: Text(widget.card.maxLevel.toString())),
                      ),
                      const Spacer(),
                    ],
                  ),
            ),
          ),
        ),
      ],
    );
  }

}
