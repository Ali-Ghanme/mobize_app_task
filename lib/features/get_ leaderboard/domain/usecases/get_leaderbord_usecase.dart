import 'package:dartz/dartz.dart';
import 'package:mobize_app/features/post_result/domain/entities/user_enitites.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_cases/use_cases.dart';
import '../repositories/get_leaderbord_repo.dart';

class GetAllStorUserDataUseCase implements UseCase<dynamic, NoParams> {
  final GetAllUserDataRepository dataRepository;
  GetAllStorUserDataUseCase({required this.dataRepository});
  @override
  Future<Either<Failure, List<UserEntities>>> call(NoParams noParams) =>
      dataRepository.getAllUser();
}
