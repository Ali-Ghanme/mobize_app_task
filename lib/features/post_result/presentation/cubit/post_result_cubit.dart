import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobize_app/features/post_result/domain/entities/user_enitites.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/usecases/store_user_data_usease.dart';

part 'post_result_state.dart';

class PostResultCubit extends Cubit<PostResultState> {
  StorUserDataUseCase storUserDataUseCase;
  PostResultCubit({required this.storUserDataUseCase})
      : super(PostResultInitial());

  Future<void> storeUserData(
      BuildContext context, UserEntities userEntities) async {
    emit(PostResultLoading());
    Either<Failure, dynamic>? response =
        await storUserDataUseCase(userEntities);
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
          return PostResultError(message: _mapFailureToMsg(failure));
        },
        (sucess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'تم تسجيل اجاباتك',
                textDirection: TextDirection.rtl,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
          );
          return PostResultLoaded(isLoaded: sucess);
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
