import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pap_report/feature/outlet/bloc/outlet_event.dart';
import 'package:pap_report/feature/outlet/model/outlet_model.dart';
import 'package:pap_report/feature/outlet/repository/repo.dart';
import 'package:pap_report/utils/generic_state/states/states.dart';

class OutletBloc extends Bloc<OutletEvent, GenericState<OutletModel>> {
  final OutletRepo _repo;

  OutletBloc(this._repo) : super(Empty()) {
    on<GetOutlets>(_onGetOutlets);
  }

  Future<void> _onGetOutlets(
      GetOutlets event, Emitter<GenericState<OutletModel>> emit) async {
    emit(Loading());
    try {
      final transaction = await _repo.getoutlet();
      emit(Success(transaction));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
