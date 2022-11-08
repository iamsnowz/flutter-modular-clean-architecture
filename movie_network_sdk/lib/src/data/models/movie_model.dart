import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'vote_average')
  double? rating;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'backdrop_path')
  String? backDrop;

  @JsonKey(name: 'poster_path')
  String? poster;

  @JsonKey(name: 'overview')
  String overview;

  @JsonKey(name: 'release_date')
  String releaseDate;

  MovieModel({
    required this.id,
    required this.rating,
    required this.title,
    required this.backDrop,
    required this.poster,
    required this.overview,
    required this.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
