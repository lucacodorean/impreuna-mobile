import 'dart:ffi';

import 'package:app/domain/entities/entity.dart';
import 'package:app/domain/entities/user.dart';
import 'package:flutter/material.dart';

class Request extends Entity {
  String id;
  String description;
  Int status;
  User requester;
  List<User> volunteers;

  Request({
    required this.id,
    required this.description,
    required this.status,
    required this.requester,
    required this.volunteers
  });
}

extension RequestHelpers on Request {
  String get requesterName     => requester.name;
  String get requesterInitials => requester.name.split(' ').map((e)=>e[0]).take(2).join();
  String get timeAgo           => DateTime.now().toString();
  Color  get statusColor       => status == 1 ? Colors.green : Colors.grey;
  List<String> get categories  => ["tbe"];
}
