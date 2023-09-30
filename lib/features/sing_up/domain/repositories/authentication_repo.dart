import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class AuthAndStoreRepository {
  Future<Either<Failure, dynamic>> authAndStore();
}
