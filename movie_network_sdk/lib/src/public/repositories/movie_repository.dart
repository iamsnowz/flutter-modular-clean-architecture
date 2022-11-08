import 'package:dartz/dartz.dart';
import 'package:movie_network_sdk/src/core/service_locator/sdk_service_locator.dart';
import 'package:movie_network_sdk/src/data/models/app_error.dart';
import 'package:movie_network_sdk/src/domain/entities/movie_entity.dart';
import 'package:movie_network_sdk/src/domain/entities/no_params.dart';
import 'package:movie_network_sdk/src/domain/usecases/get_trending_usecase.dart';

class MovieRepository {
  Future<Either<AppError, List<MovieEntity>>> getTrending() async {
    return await serviceLocator<GetTrendingUseCase>().call(params: NoParams());
  }
}
