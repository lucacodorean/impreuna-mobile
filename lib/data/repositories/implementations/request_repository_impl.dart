import 'package:app/data/datasources/request_data_source.dart';
import 'package:app/data/models/responses/request_response.dart';
import 'package:app/domain/entities/request.dart';

import '../request_repository.dart';

class RequestRepositoryImpl extends RequestRepository {
  final RequestDataSource remote;

  RequestRepositoryImpl({
    required this.remote,
  });

  @override
  Future<List<Request>> all() async {
    final List<RequestResponse> response = await remote.all();
    return response.map((element) => element.request.toEntity()).toList();
  }
}