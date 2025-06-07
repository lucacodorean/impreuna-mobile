import 'package:app/domain/entities/request.dart';
import 'package:app/domain/usecases/request_all_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestViewModel extends StateNotifier<AsyncValue<List<Request>>> {
  final RequestAllUseCase _useCase;
  RequestViewModel(this._useCase) : super(const AsyncData([])) { all(); }

  Future<void> all() async {
    state = const AsyncLoading();
    try {
      final response = await _useCase.execute();
      state = AsyncData(response);
    } catch(error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}