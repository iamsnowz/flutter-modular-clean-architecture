import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_network_sdk/src/data/models/movie_result_model.dart';
import 'package:movie_network_sdk/src/domain/entities/no_params.dart';

import 'package:movie_network_sdk/src/domain/repo/movie_repo.dart';
import 'package:movie_network_sdk/src/domain/usecases/get_trending_usecase.dart';

import '../../fixtures_reader.dart';
import 'get_trending_usecase_test.mocks.dart';

@GenerateMocks([MovieRepo])
main() {
  late MockMovieRepo mockMovieRepo;
  late GetTrendingUseCase usecase;
  setUp(() {
    mockMovieRepo = MockMovieRepo();
    usecase = GetTrendingUseCase(mockMovieRepo);
  });

  group('description', () {
    test('description', () async {
      final json = 'trending.json'.toFixture();
      final value = MovieResultModel.fromJson(json);
      
      when(mockMovieRepo.getTrending()).thenAnswer(
        (_) => Future.value(Right(value.movies)),
      );

      final response = await usecase.call(params: NoParams());
      response.fold(
        (l) => null,
        (r) => expect(r.length, value.movies.length),
      );
    });
  });
}
