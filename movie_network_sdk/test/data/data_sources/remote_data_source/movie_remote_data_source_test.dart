import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_network_sdk/src/core/constant/global_constant.dart';
import 'package:movie_network_sdk/src/data/data_sources/remote_data_source/movie_remote_data_source.dart';
import 'package:movie_network_sdk/src/data/models/movie_result_model.dart';
import 'package:movie_network_sdk/src/data/repo/movie_repo_impl.dart';
import 'package:movie_network_sdk/src/domain/repo/movie_repo.dart';
import 'package:retrofit/dio.dart';

import '../../../fixtures_reader.dart';
import 'movie_remote_data_source_test.mocks.dart';

@GenerateMocks([MovieRemoteDataSource])
main() {
  late MovieRepo movieRepo;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;
  late Dio dio;
  late DioAdapter dioAdapter;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: BASE_URL));
    dioAdapter = DioAdapter(dio: dio);
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    movieRepo = MovieRepoImpl(mockMovieRemoteDataSource);
  });

  group('Get Trending', () {
    test('should return List<MovieModel> when the response is 200 (success)',
        () async {
      final json = 'trending.json'.toFixture();
      const route =
          'trending/movie/day?api_key=2bcf8c88652b69f33be463775e3715a1';
      dioAdapter.onGet(route, (server) => server.reply(200, json));
      final result = await dio.get(route);
      final value = MovieResultModel.fromJson(json);
      final httpResponse = HttpResponse(value, result);

      when(mockMovieRemoteDataSource.getTrending())
          .thenAnswer((_) async => httpResponse);

      final response = await movieRepo.getTrending();
      response.fold(
        (l) => null,
        (r) => expect(r, httpResponse.data.movies),
      );
    });
  });
}
