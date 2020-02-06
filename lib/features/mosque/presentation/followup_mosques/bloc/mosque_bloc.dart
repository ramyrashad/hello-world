import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class MosqueBloc extends Bloc<MosqueEvent, MosqueState> {
  @override
  MosqueState get initialState => InitialMosqueState();

  @override
  Stream<MosqueState> mapEventToState(
    MosqueEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
