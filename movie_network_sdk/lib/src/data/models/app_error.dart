import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final AppErrorType appErrorType;
  final DioError? error;

  const AppError({
    required this.appErrorType,
    this.error,
  });

  @override
  List<Object?> get props => [appErrorType, error];
}

enum AppErrorType {
  api,
  network,
  database,
  unauthorised,
  sessionDenied,
  failed
}
