
class Review {
  final String id;
  final List<String> user;
  final List<String> landmark;
  final int stars;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Review({
    required this.id,
    required this.user,
    required this.landmark,
    required this.stars,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      user: List<String>.from(json['user']),
      landmark: List<String>.from(json['landmark']),
      stars: json['stars'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'landmark': landmark,
      'stars': stars,
      'message': message,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }

  @override
  String toString() {
    return '{id: $id, user: $user, landmark: $landmark, stars: $stars, message: $message, createdAt: $createdAt, updatedAt: $updatedAt, v: $v}';
  }

}