part of 'sing_up_cubit.dart';

abstract class SingUpState extends Equatable {
  const SingUpState();

  @override
  List<Object> get props => [];
}

class SingUpInitial extends SingUpState {}

class SingUpLoading extends SingUpState {}

class SingUpSucess extends SingUpState {
  final dynamic sucess;
  const SingUpSucess({required this.sucess});
  @override
  List<Object> get props => [sucess];
}

class SingUpFailed extends SingUpState {
  final String message;
  const SingUpFailed({required this.message});
  @override
  List<Object> get props => [message];
}
