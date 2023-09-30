import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../core/network/network_info.dart';
import '../features/get_ leaderboard/data/datasources/get_leaderbord.dart';
import '../features/get_ leaderboard/data/repositories/get_leaderbord_repo_impl.dart';
import '../features/get_ leaderboard/domain/repositories/get_leaderbord_repo.dart';
import '../features/get_ leaderboard/domain/usecases/get_leaderbord_usecase.dart';
import '../features/get_ leaderboard/presentation/cubit/get_leaderboard_cubit.dart';
import '../features/post_result/data/datasources/store_use_data_sourc.dart';
import '../features/post_result/data/repositories/store_user_repo_impl.dart';
import '../features/post_result/domain/repositories/store_user_data_repo.dart';
import '../features/post_result/domain/usecases/store_user_data_usease.dart';
import '../features/post_result/presentation/cubit/post_result_cubit.dart';
import '../features/sing_up/data/datasources/auth_store_data_souce.dart';
import '../features/sing_up/data/repositories/auth_store_repo_impl.dart';
import '../features/sing_up/domain/repositories/authentication_repo.dart';
import '../features/sing_up/domain/usecases/authentication_usecase.dart';
import '../features/sing_up/presentation/cubit/sing_up_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //======================== Cubit =============================================
  sl.registerFactory<SingUpCubit>(
    () => SingUpCubit(authUseCase: sl()),
  ); //==
  sl.registerFactory<GetLeaderboardCubit>(
    () => GetLeaderboardCubit(
      getAllStorUserDataUseCase: sl(),
    ),
  ); //==
  sl.registerFactory<PostResultCubit>(
    () => PostResultCubit(
      storUserDataUseCase: sl(),
    ),
  );

  // ==========================Use Cases========================================
  //==
  sl.registerLazySingleton(
    () => AuthUseCase(
      andStoreRepository: sl(),
    ),
  );
  //==
  sl.registerLazySingleton(
    () => StorUserDataUseCase(
      storUserDataRepository: sl(),
    ),
  );
  //==
  sl.registerLazySingleton(
    () => GetAllStorUserDataUseCase(
      dataRepository: sl(),
    ),
  );

  //==========================Repository========================================
  //==
  sl.registerLazySingleton<AuthAndStoreRepository>(
    () => GetLostRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  //==
  sl.registerLazySingleton<StorUserDataRepository>(
    () => StorUserDataRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  //==
  sl.registerLazySingleton<GetAllUserDataRepository>(
    () => GetAllUserDataRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  //==========================Data Sources======================================
  //==
  sl.registerLazySingleton<AuthAndStoreRemoteDataSource>(
    () => AuthAndStoreRemoteDataSourceImpl(),
  );
  //==
  sl.registerLazySingleton<StorUserDataRemoteDataSource>(
    () => StorUserDataRemoteDataSourceImpl(),
  );
  //==
  sl.registerLazySingleton<GetAllUserDataRemoteDataSource>(
    () => GetAllUserDataRemoteDataSourceImpl(),
  );

  //========================== Core ==========================================
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectionChecker: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
  sl.registerLazySingleton(
    () => OneSignal(),
  );
}
