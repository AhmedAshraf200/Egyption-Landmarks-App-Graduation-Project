
class UserModel {
  String id;
  String name;
  String email;
  bool isAdmin;

  UserModel({required this.id, required this.name, required this.email, required this.isAdmin});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      isAdmin: json['isAdmin'],
    );
  }
}

class UserData {
  UserModel user;
  String accessToken;

  UserData({required this.user, required this.accessToken});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: UserModel.fromJson(json['user']),
      accessToken: json['access_token'],
    );
  }
}