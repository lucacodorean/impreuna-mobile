import 'dart:ffi';

import 'package:app/data/models/dtos/user_model.dart';
import 'package:app/domain/entities/request.dart';

class RequestModel {
  final String id;
  final String description;
  final Int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String self;
  final String parent;
  final UserModel requester;
  final List<UserModel>? volunteers;

  RequestModel({
    required this.id,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.requester,
    this.volunteers,
    required this.self,
    required this.parent
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id:    json["id"],
      description:  json["attributes"]["description"],
      status: json["attributes"]["status"],
      createdAt: DateTime.parse(json["attributes"]["created_at"]),
      updatedAt: DateTime.parse(json["attributes"]["updated_at"]),

      requester: UserModel.fromJson(json["relationships"]["requester"]),

      volunteers:  (json['relationships']?['volunteers'] as List<dynamic>?)
          ?.map((item) => UserModel.fromJson(item as Map<String, dynamic>))
          .toList(),

      self: json['links']['self'],
      parent: json['links']['parent'],
    );
  }

  Request toEntity() => Request(
    id:  id,
    description: description,
    status: status,
    requester: requester.toEntity(),
    volunteers: volunteers!.map((element) => element.toEntity()).toList()
  );
}
