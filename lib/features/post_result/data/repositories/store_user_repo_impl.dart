import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user_enitites.dart';
import '../../domain/repositories/store_user_data_repo.dart';
import '../datasources/store_use_data_sourc.dart';

class StorUserDataRepositoryImpl implements StorUserDataRepository {
  final NetworkInfo? networkInfo;
  final StorUserDataRemoteDataSource remoteDataSource;

  StorUserDataRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, dynamic>> storeUserEntities(
      UserEntities userEntities) async {
    if (await networkInfo!.isConnected) {
      try {
        final remoteLiveStream =
            await remoteDataSource.storeUserEntities(userEntities);
        return Right(remoteLiveStream);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        return Left(CacheFailure());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
