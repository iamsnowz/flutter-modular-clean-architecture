import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_network_sdk/src/data/data_sources/remote_data_source/movie_remote_data_source.dart';
import 'package:movie_network_sdk/src/data/models/app_error.dart';
import 'package:movie_network_sdk/src/data/models/movie_model.dart';
import 'package:movie_network_sdk/src/domain/repo/movie_repo.dart';

class MovieRepoImpl extends MovieRepo {
  final MovieRemoteDataSource _remoteDataSource;

  MovieRepoImpl(this._remoteDataSource);

  @override
  Future<Either<AppError, List<MovieModel>>> getTrending() async {
    try {
      final httpResponse = await _remoteDataSource.getTrending();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return Right(httpResponse.data.movies);
      } else {
        return Left(
          AppError(
            appErrorType: AppErrorType.failed,
            error: DioError(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              requestOptions: httpResponse.response.requestOptions,
              type: DioErrorType.response,
            ),
          ),
        );
      }
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.api));
    }
  }
}
