class ClashCard {
  String? name;
  int? id;
  int? maxLevel;
  String? iconUrls;

  ClashCard({this.name, this.id, this.maxLevel, this.iconUrls});

  ClashCard.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    maxLevel = json['maxLevel'];
    iconUrls = json['iconUrls'];
  }

  factory ClashCard.fromMap(Map<String, dynamic> map){
    return ClashCard(
      name: map['name'],
      id: map['id'],
      maxLevel: map['maxLevel'],
      iconUrls: map['iconUrls']['medium'],
    );
  }

}

