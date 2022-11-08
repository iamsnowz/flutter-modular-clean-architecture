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

import 'movie_remote_data_source_test.mocks.dart';

final data = {
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/zzoFeH4PsV5Mh2Sc47JOMFwGYOX.jpg",
      "id": 829280,
      "title": "Enola Holmes 2",
      "original_language": "en",
      "original_title": "Enola Holmes 2",
      "overview":
          "Now a detective-for-hire like her infamous brother, Enola Holmes takes on her first official case to find a missing girl, as the sparks of a dangerous conspiracy ignite a mystery that requires the help of friends — and Sherlock himself — to unravel.",
      "poster_path": "/tegBpjM5ODoYoM1NjaiHVLEA0QM.jpg",
      "media_type": "movie",
      "genre_ids": [9648, 12, 80],
      "popularity": 591.879,
      "release_date": "2022-11-04",
      "video": false,
      "vote_average": 7.802,
      "vote_count": 426
    }
  ]
};

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
    test(
        'should perform a GET request on /trending/movie/day?api_key=2bcf8c88652b69f33be463775e3715a1',
        () async {
      const route =
          'trending/movie/day?api_key=2bcf8c88652b69f33be463775e3715a1';
      dioAdapter.onGet(route, (server) => server.reply(200, data));
      final result = await dio.get(route);
      final value = MovieResultModel.fromJson(data);
      final httpResponse = HttpResponse(value, result);

      when(mockMovieRemoteDataSource.getTrending())
          .thenAnswer((_) async => httpResponse);

      final response = await movieRepo.getTrending();
      response.fold((l) => null, (r) => expect(r, httpResponse.data.movies));
    });
  });
}
