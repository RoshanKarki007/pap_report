import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pap_report/feature/transaction/bloc/events.dart';
import 'package:pap_report/feature/transaction/model/transaction_model.dart';
import 'package:pap_report/feature/transaction/repository/repo.dart';
import 'package:pap_report/utils/api_exceptions.dart';
import 'package:pap_report/utils/generic_state/states/states.dart';

class TransactionBloc
    extends Bloc<TransactionEvent, GenericState<TransactionModel>> {
  final TransactionRepo _repo;

  TransactionBloc(this._repo) : super(Empty()) {
    on<GetTransactions>(_onGetTransactions);
  }

  Future<void> _onGetTransactions(GetTransactions event,
      Emitter<GenericState<TransactionModel>> emit) async {
    emit(Loading());
    try {
      final transaction = await _repo.getTransaction();
      emit(Success(transaction));
    } on ApiException catch (error) {
      emit(Error(error.message.toString(), statusCode: error.statusCode));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
