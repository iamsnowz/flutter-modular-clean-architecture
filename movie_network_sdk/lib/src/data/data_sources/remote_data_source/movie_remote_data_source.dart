import 'package:dio/dio.dart';
import 'package:movie_network_sdk/src/core/constant/global_constant.dart';
import 'package:movie_network_sdk/src/data/models/movie_result_model.dart';
import 'package:retrofit/retrofit.dart';

part 'movie_remote_data_source.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class MovieRemoteDataSource {
  factory MovieRemoteDataSource(Dio dio, {String? baseUrl}) {
    return _MovieRemoteDataSource(dio, baseUrl: baseUrl);
  }
  @GET('/trending/movie/day?api_key=$API_KEY')
  Future<HttpResponse<MovieResultModel>> getTrending();
}
