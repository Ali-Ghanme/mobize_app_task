import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobize_app/features/post_result/domain/entities/user_enitites.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_cases/use_cases.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/usecases/get_leaderbord_usecase.dart';

part 'get_leaderboard_state.dart';

class GetLeaderboardCubit extends Cubit<GetLeaderboardState> {
  GetAllStorUserDataUseCase getAllStorUserDataUseCase;
  GetLeaderboardCubit({required this.getAllStorUserDataUseCase})
      : super(GetLeaderboardInitial());

  Future<void> getAllUserData() async {
    emit(GetLeaderboardLoading());
    Either<Failure, dynamic>? response =
        await getAllStorUserDataUseCase(NoParams());
    emit(
      response.fold(
        (failure) {
          return GetLeaderboardError(message: _mapFailureToMsg(failure));
        },
        (data) {
          return GetLeaderboardLoaded(users: data);
        },
      ),
    );
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unexpecredError;
    }
  }
}
