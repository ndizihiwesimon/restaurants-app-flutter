class Restaurant {
  final int id;
  final String name;
  final String owner;
  final int rating;
  final String district;
  final String sector;

  Restaurant({
    required this.id,
    required this.name,
    required this.owner,
    required this.rating,
    required this.district,
    required this.sector,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      owner: json['owner'],
      rating: json['rating'],
      district: json['district'],
      sector: json['sector'],
    );
  }
}
