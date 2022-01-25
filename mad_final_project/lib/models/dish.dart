class Dish {
  int id;
  String name;
  String cookTime;
  List<String> ingredients;
  List<Pictures> pictures;
  String price;

  Dish(
      {required this.id,
      required this.name,
      required this.cookTime,
      required this.ingredients,
      required this.pictures,
      required this.price});

  factory Dish.fromJson(Map<String, dynamic> json) {
    var list = json['pictures'] as List;
    List<Pictures> picList = list.map((pictures) => Pictures.fromJson(pictures)).toList();
    return Dish(
      id : json['id'],
    name : json['name'],
    cookTime : json['cookTime'],
    ingredients : json['ingredients'].cast<String>(),
    price : json['price'],
    pictures: picList
    );
    
  }

}

class Pictures {
  int id;
  String image;

  Pictures({required this.id, required this.image});

  factory Pictures.fromJson(Map<String, dynamic> json) {
    return Pictures(
      id: json['id'],
      image: json['image'],
    );
  }
}
