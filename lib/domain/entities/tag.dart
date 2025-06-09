import 'dart:ui';

import 'package:app/domain/entities/entity.dart';
import 'package:flutter/material.dart';

class Tag extends Entity {
  int id;
  String name;
  Color color;

  Tag({
    required this.id,
    required this.name,
    required this.color,
  });
}