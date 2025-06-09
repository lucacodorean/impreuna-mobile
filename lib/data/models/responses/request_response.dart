import 'package:app/data/models/dtos/request_model.dart';

class RequestResponse {
  final RequestModel request;
  RequestResponse({required this.request});

  factory RequestResponse.fromJson(Map<String, dynamic> json) {
    return RequestResponse(
        request:  RequestModel.fromJson(json)
    );
  }
}