import 'package:app/data/repositories/request_repository.dart';
import 'package:app/domain/entities/request.dart';

class RequestAllUseCase {
  final RequestRepository _requestRepository;
  RequestAllUseCase(this._requestRepository);

  Future<List<Request>> execute() {
    return _requestRepository.all();
  }
}