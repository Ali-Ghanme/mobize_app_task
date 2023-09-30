import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../post_result/domain/entities/user_enitites.dart';

abstract class GetAllUserDataRepository {
  Future<Either<Failure, List<UserEntities>>> getAllUser();
}
