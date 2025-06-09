import 'package:app/data/models/responses/request_response.dart';
import 'package:dio/dio.dart';

class RequestDataSource {
  final Dio dio;
  RequestDataSource({required this.dio});

  Future<List<RequestResponse>> all() async {
      final resp = await dio.get(
        "/requests?include=user,volunteers,tags",
        data: {},
        options: Options(headers: {
          'Connection': 'close',
          'Accept': 'application/json',
        }),
      );

      final List<dynamic> rawList = resp.data['data'] as List<dynamic>;
      final requests = rawList
          .map((item) => RequestResponse.fromJson(item as Map<String, dynamic>))
          .toList();

      return requests;
  }
}