import 'package:app/domain/entities/user.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final DateTime createdAt;
  final DateTime updatedAt;
  // final String self;
  // final String parent;


  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.createdAt,
    required this.updatedAt,
    // required this.self,
    // required this.parent
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id:    json["id"],
      name:  json["attributes"]["name"],
      email: json["attributes"]["email"],
      avatar: json["attributes"]["profile_photo_url"],
      createdAt: DateTime.parse(json["attributes"]["created_at"]),
      updatedAt: DateTime.parse(json["attributes"]["updated_at"]),
      // self: json['links']['self'],
      // parent: json['links']['parent'],
    );
  }

  User toEntity() => User(id: id, name: name, email: email, avatar: avatar);
}
