import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_cases/use_cases.dart';
import '../entities/user_enitites.dart';
import '../repositories/store_user_data_repo.dart';

class StorUserDataUseCase implements UseCase<dynamic, UserEntities> {
  final StorUserDataRepository storUserDataRepository;
  StorUserDataUseCase({required this.storUserDataRepository});
  @override
  Future<Either<Failure, dynamic>> call(UserEntities userEntities) =>
      storUserDataRepository.storeUserEntities(userEntities);
}
