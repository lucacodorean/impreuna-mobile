import 'package:app/domain/entities/request.dart';

abstract class RequestRepository {
  Future<List<Request>> all();
}