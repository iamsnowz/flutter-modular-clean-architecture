import 'package:dartz/dartz.dart';
import 'package:movie_network_sdk/src/data/models/app_error.dart';

abstract class UseCase<Type, Params> {
  Future<Either<AppError, Type>> call({required Params params});
}
