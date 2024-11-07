class ResultFilterModel {
  String id;
  String name;
  String createdAt;
  String updatedAt;
  int v;

  ResultFilterModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ResultFilterModel.fromJson(Map<String, dynamic> json) {
    return ResultFilterModel(
      id: json['_id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = v;
    return data;
  }
}
