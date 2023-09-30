import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobize_app/core/error/failure.dart';
import 'package:mobize_app/core/use_cases/use_cases.dart';
import 'package:mobize_app/core/utils/app_colors.dart';
import 'package:mobize_app/core/utils/app_strings.dart';
import 'package:mobize_app/features/sing_up/domain/usecases/authentication_usecase.dart';

part 'sing_up_state.dart';

class SingUpCubit extends Cubit<SingUpState> {
  AuthUseCase authUseCase;
  SingUpCubit({required this.authUseCase}) : super(SingUpInitial());

  Future<void> authAndstore(BuildContext context) async {
    emit(SingUpLoading());
    Either<Failure, dynamic>? response = await authUseCase(NoParams());
    emit(
      response.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.aleart,
              content: Text(
                'أجب على كل الأسئلة',
                textDirection: TextDirection.rtl,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
          );
          return SingUpFailed(message: _mapFailureToMsg(failure));
        },
        (sucess) {
          return SingUpSucess(sucess: sucess);
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
