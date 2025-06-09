import 'dart:math';

import 'package:app/domain/entities/tag.dart';
import 'package:flutter/material.dart';

class TagModel {
  final int id;
  final String name;

  TagModel({
    required this.id,
    required this.name,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id:    json["id"],
      name:  json["attributes"]["name"],
    );
  }

  Tag toEntity() => Tag(
      id: id,
      name: name,
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade300
  );
}
