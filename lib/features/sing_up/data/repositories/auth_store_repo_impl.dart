import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/authentication_repo.dart';
import '../datasources/auth_store_data_souce.dart';

class GetLostRepositoryImpl implements AuthAndStoreRepository {
  final NetworkInfo? networkInfo;
  final AuthAndStoreRemoteDataSource remoteDataSource;

  GetLostRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, dynamic>> authAndStore() async {
    if (await networkInfo!.isConnected) {
      try {
        final remoteLiveStream = await remoteDataSource.authAndStore();
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
