import 'package:flutter/material.dart';
import '../screens/details_clash_card.dart';
import 'package:clash_api/models/card_clash_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// ignore: must_be_immutable
class ItemClashCard extends StatefulWidget {
  ClashCard card;
  ItemClashCard({Key? key, required this.card}) : super(key: key);

  @override
  State<ItemClashCard> createState() => _ItemClashCardState();
}

class _ItemClashCardState extends State<ItemClashCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => CardClashDetailsScreen(
                  card: widget.card,
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 4),
                  alignment: Alignment.center,
                  child: Image.network(
                    widget.card.iconUrls!,
                    fit: BoxFit.scaleDown,
                    loadingBuilder: (context, child, loadingProgress) {
                      if(loadingProgress==null){
                        return child;
                      }else{
                        return LoadingAnimationWidget.hexagonDots(color: Colors.black45, size: 26);
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.card.name!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 0),
                    Text(
                      'Max Level: ${widget.card.maxLevel}',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
