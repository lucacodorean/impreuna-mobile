
import 'package:app/domain/entities/entity.dart';

class User extends Entity {
   String id;
   String name;
   String email;
   String avatar;


  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar
  });
}