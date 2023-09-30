import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_cases/use_cases.dart';
import '../repositories/authentication_repo.dart';

class AuthUseCase implements UseCase<dynamic, NoParams> {
  AuthAndStoreRepository andStoreRepository;
  AuthUseCase({required this.andStoreRepository});
  @override
  Future<Either<Failure, dynamic>> call(NoParams parms) =>
      andStoreRepository.authAndStore();
}
