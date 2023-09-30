import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params parms);
}

abstract class TowAraguUseCase<Type, Params, Param> {
  Future<Either<Failure, Type>> call(Params parms, Param param);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class Param extends Equatable {
  final int parameter;
  const Param({required this.parameter});
  @override
  List<Object?> get props => [parameter];
}

class ParamOne extends Equatable {
  final String parameter;
  const ParamOne({required this.parameter});
  @override
  List<Object?> get props => [parameter];
}

class TowParams extends Equatable {
  final int? parameterOne;
  final String? parameterTow;
  final int? parmterThree;

  const TowParams({
    this.parameterOne,
    this.parameterTow,
    this.parmterThree,
  });
  @override
  List<Object?> get props => [parameterOne, parameterTow, parmterThree];
}

class TowParamsInt extends Equatable {
  final int? parameterOne;
  final int? parameterTow;
  const TowParamsInt({
    required this.parameterOne,
    required this.parameterTow,
  });
  @override
  List<Object?> get props => [
        parameterOne,
        parameterTow,
      ];
}

class Params extends Equatable {
  final Map<String, dynamic> parameters;

  const Params({required this.parameters});

  @override
  List<Object?> get props => [parameters];
}

class ParamsForTwjehe extends Equatable {
  final String name;
  final int number;
  final String token;
  final String ip;

  const ParamsForTwjehe({
    required this.name,
    required this.number,
    required this.token,
    required this.ip,
  });

  @override
  List<Object?> get props => [name, number, token, ip];
}

class ParamsForInfoVideo extends Equatable {
  final int videoTypeId;
  final String token;
  final int pageNum;

  const ParamsForInfoVideo({
    required this.videoTypeId,
    required this.token,
    required this.pageNum,
  });

  @override
  List<Object?> get props => [videoTypeId, token, pageNum];
}
