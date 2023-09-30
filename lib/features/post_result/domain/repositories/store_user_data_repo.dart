import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_enitites.dart';

abstract class StorUserDataRepository {
  Future<Either<Failure, dynamic>> storeUserEntities(
      UserEntities userEntities);
}
