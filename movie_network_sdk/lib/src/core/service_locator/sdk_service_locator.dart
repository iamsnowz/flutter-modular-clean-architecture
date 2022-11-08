import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_network_sdk/src/core/api/api_client.dart';
import 'package:movie_network_sdk/src/core/logger/logger.dart';
import 'package:movie_network_sdk/src/data/data_sources/remote_data_source/movie_remote_data_source.dart';
import 'package:movie_network_sdk/src/data/repo/movie_repo_impl.dart';
import 'package:movie_network_sdk/src/domain/repo/movie_repo.dart';
import 'package:movie_network_sdk/src/domain/usecases/get_trending_usecase.dart';

/// Global GetIt instance
final serviceLocator =
    GetIt.asNewInstance(); // sl is referred to as Service Locator

/// Service Locator class to init Get It
class SdkServiceLocator {
  /// Dependency injection
  static Future<void> initServiceLocator({bool sync = false}) async {
    DateTime startTime = DateTime.now();

    /// * ----------------------------------- Data Layer -----------------------------------///
    serviceLocator.registerLazySingleton<Dio>(() => ApiClient().dio);

    serviceLocator.registerLazySingleton<MovieRemoteDataSource>(
        () => MovieRemoteDataSource(serviceLocator()));

    ///* ----------------------------------- Domain Layer -----------------------------------///
    // * Repo
    serviceLocator.registerLazySingleton<MovieRepo>(
        () => MovieRepoImpl(serviceLocator()));

    // * UseCase
    serviceLocator.registerLazySingleton<GetTrendingUseCase>(
        () => GetTrendingUseCase(serviceLocator()));

    DateTime endTime = DateTime.now();

    // * wait to init all the dependency.
    if (sync) await serviceLocator.allReady();
    logger.d(
        '>> Time took to initilize the DI ${endTime.difference(startTime).inMilliseconds} Milis');
  }
}
