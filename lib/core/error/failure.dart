import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NotFoundFailure extends Failure {
  final String message;
  NotFoundFailure({required this.message});
}
