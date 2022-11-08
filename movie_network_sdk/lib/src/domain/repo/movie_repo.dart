import 'package:dartz/dartz.dart';
import 'package:movie_network_sdk/src/data/models/app_error.dart';
import 'package:movie_network_sdk/src/data/models/movie_model.dart';

abstract class MovieRepo {
  Future<Either<AppError, List<MovieModel>>> getTrending();
}
