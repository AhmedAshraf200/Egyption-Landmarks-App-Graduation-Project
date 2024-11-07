class HomeLandMarksModel {

  final int page;
  final int totalItems;
  final int pageSize;
  final int totalPages;
  final List<HomeMarks> data;

  HomeLandMarksModel({
    required this.page,
    required this.totalItems,
    required this.pageSize,
    required this.totalPages,
    required this.data,
  });

  factory HomeLandMarksModel.fromJson(json) {
    List<HomeMarks> landmark = List<HomeMarks>.from(
      json['data'].map((data) => HomeMarks.fromJson(data)),
    );

    return HomeLandMarksModel(
      page: json['page'],
      totalItems: json['totalItems'],
      pageSize: json['pageSize'],
      totalPages: json['totalPages'],
      data: landmark,
    );
  }
}



class HomeMarks {
  final String id;
  final String name;
  final int price;
  late int likesCount;
  final String coverImage;
  final int views;

  HomeMarks({
    required this.id,
    required this.name,
    required this.views,
    required this.price,
    required this.likesCount,
    required this.coverImage,
  });

  factory HomeMarks.fromJson(Map<String, dynamic> json) {
    return HomeMarks(
      id: json['_id'],
      name: json['name'],
      price: json['price'],
      views: json['views'],
      likesCount: json['likes_count'],
      coverImage: json['cover_image'],
    );
  }
}