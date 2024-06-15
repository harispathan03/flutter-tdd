// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_app_tdd/core/error/exception.dart';
import 'package:weather_app_tdd/core/error/failure.dart';
import 'package:weather_app_tdd/data/data_sources/remote_data_source.dart';
import 'package:weather_app_tdd/domain/entities/weather.dart';
import 'package:weather_app_tdd/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepositoryImpl({
    required this.weatherRemoteDataSource,
  });

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String lat, String long) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(lat, long);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure("Server Error!"));
    } on SocketException {
      return const Left(ConnectionFailure("Failure to connect to the network"));
    }
  }
}
