// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
      id: json['id'] as int,
      rating: (json['vote_average'] as num?)?.toDouble(),
      title: json['title'] as String,
      backDrop: json['backdrop_path'] as String?,
      poster: json['poster_path'] as String?,
      overview: json['overview'] as String,
      releaseDate: json['release_date'] as String,
    );

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vote_average': instance.rating,
      'title': instance.title,
      'backdrop_path': instance.backDrop,
      'poster_path': instance.poster,
      'overview': instance.overview,
      'release_date': instance.releaseDate,
    };
