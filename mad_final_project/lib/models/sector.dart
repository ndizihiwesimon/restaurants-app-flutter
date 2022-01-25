
class Sector {
  final int id;
  final String name;

  Sector({
    required this.id,
    required this.name,
  });

  factory Sector.fromJson(Map<String, dynamic> json) {
    return Sector(
      id: json['id'],
      name: json['name'],
    );
  }
}
