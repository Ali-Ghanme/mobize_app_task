part of 'post_result_cubit.dart';

abstract class PostResultState extends Equatable {
  const PostResultState();

  @override
  List<Object> get props => [];
}

class PostResultInitial extends PostResultState {}

class PostResultLoading extends PostResultState {}

class PostResultLoaded extends PostResultState {
  final dynamic isLoaded;

  const PostResultLoaded({required this.isLoaded});
  @override
  List<Object> get props => [isLoaded];
}

class PostResultError extends PostResultState {
  final String message;
  const PostResultError({required this.message});
  @override
  List<Object> get props => [message];
}
