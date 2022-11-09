import 'package:dartz/dartz.dart';
import 'package:movie_network_sdk/src/core/usecase/usecase.dart';
import 'package:movie_network_sdk/src/data/models/app_error.dart';
import 'package:movie_network_sdk/src/domain/entities/movie_entity.dart';
import 'package:movie_network_sdk/src/domain/entities/no_params.dart';
import 'package:movie_network_sdk/src/domain/repo/movie_repo.dart';

class GetTrendingUseCase extends UseCase<List<MovieEntity>, NoParams> {
  final MovieRepo repository;

  GetTrendingUseCase(this.repository);

  @override
  Future<Either<AppError, List<MovieEntity>>> call(
      {required NoParams params}) async {
    final response = await repository.getTrending();
    return response.fold(
      (l) => Left(l),
      (r) {
        return Right(r
            .map(
              (e) => MovieEntity(
                e.overview,
                posterPath: e.poster ?? "",
                id: e.id,
                backdropPath: e.backDrop ?? "",
                title: e.title,
                voteAverage: e.rating ?? 0,
                releaseDate: e.releaseDate,
              ),
            )
            .toList());
      },
    );
  }
}
