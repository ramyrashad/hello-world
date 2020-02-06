import 'package:equatable/equatable.dart';

abstract class MosqueState extends Equatable {
  const MosqueState();
}

class InitialMosqueState extends MosqueState {
  @override
  List<Object> get props => [];
}
