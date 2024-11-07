class LandMarksModel {
  final String id;
  final String name;
  final String description;
  final String? era;
  final String? famousFigures;
  final Location location; // Adjusted to String type
  final City city;
  final List<Tag> tags;
  final List<String> images;
  final double price;
  final String openingHours;
  int likesCount;
  final String coverImage;
  final bool isRecommended;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  LandMarksModel({
    required this.id,
    required this.name,
    required this.description,
    required this.era,
    required this.famousFigures,
    required this.location,
    required this.city,
    required this.tags,
    required this.images,
    required this.price,
    required this.openingHours,
    required this.likesCount,
    required this.coverImage,
    required this.isRecommended,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory LandMarksModel.fromJson(Map<String, dynamic> json) {
    return LandMarksModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      era: json['era'],
      famousFigures: json['famous_figures'],
      location: Location.fromJson(json['location']), // Adjusted to access the 'name' field of the location object
      city: City.fromJson(json['city']),
      tags: (json['tags'] as List<dynamic>)
          .map((tag) => Tag.fromJson(tag))
          .toList(),
      images: List<String>.from(json['images']),
      price: json['price'].toDouble(),
      openingHours: json['opening_hours'],
      likesCount: json['likes_count'] ?? 0, // Provide a default value if 'likes_count' is not present
      coverImage: json['cover_image'],
      isRecommended: json['is_recommended'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

}


class City {
  final String id;
  final String name;

  City({required this.id, required this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class Tag {
  final String id;
  final String name;

  Tag({required this.id, required this.name});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['_id'],
      name: json['name'],
    );
  }
}








class Location {
  String id;
  String name;
  double latitude;
  double longitude;
  int v;

  Location({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.v,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['_id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      v: json['__v'],
    );
  }
}
