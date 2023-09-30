part of 'get_leaderboard_cubit.dart';

abstract class GetLeaderboardState extends Equatable {
  const GetLeaderboardState();

  @override
  List<Object> get props => [];
}

class GetLeaderboardInitial extends GetLeaderboardState {}

class GetLeaderboardLoading extends GetLeaderboardState {}

class GetLeaderboardLoaded extends GetLeaderboardState {
  final List<UserEntities> users;
  const GetLeaderboardLoaded({required this.users});
  @override
  List<Object> get props => [users];
}

class GetLeaderboardError extends GetLeaderboardState {
  final String message;
  const GetLeaderboardError({required this.message});
  @override
  List<Object> get props => [message];
}
