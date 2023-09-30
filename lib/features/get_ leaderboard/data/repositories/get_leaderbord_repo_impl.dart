import 'package:dartz/dartz.dart';
import 'package:mobize_app/features/post_result/domain/entities/user_enitites.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/get_leaderbord_repo.dart';
import '../datasources/get_leaderbord.dart';

class GetAllUserDataRepositoryImpl implements GetAllUserDataRepository {
  final NetworkInfo? networkInfo;
  final GetAllUserDataRemoteDataSource remoteDataSource;

  GetAllUserDataRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<UserEntities>>> getAllUser() async {
    if (await networkInfo!.isConnected) {
      try {
        final remoteLiveStream = await remoteDataSource.getAllUsers();
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
