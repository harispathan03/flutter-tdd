import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_tdd/core/error/exception.dart';
import 'package:weather_app_tdd/core/error/failure.dart';
import 'package:weather_app_tdd/data/models/weather_model.dart';
import 'package:weather_app_tdd/data/repositories/weather_repository_impl.dart';
import 'package:weather_app_tdd/domain/entities/weather.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
        weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const weatherModel = WeatherModel(
      cityName: "New york",
      main: "main",
      description: "description",
      iconCode: "iconCode",
      temprature: 50,
      pressure: 5,
      humidity: 3);

  const weatherEntity = WeatherEntity(
      cityName: "New york",
      main: "main",
      description: "description",
      iconCode: "iconCode",
      temprature: 50,
      pressure: 5,
      humidity: 3);

  group("get current weather", () {
    test("should return current weather when api call succeeds", () async {
      when(mockWeatherRemoteDataSource.getCurrentWeather("12.12", "12.12"))
          .thenAnswer((realInvocation) async {
        return weatherModel;
      });

      final result =
          await weatherRepositoryImpl.getCurrentWeather("12.12", "12.12");
      expect(result, equals(const Right(weatherEntity)));
    });
  });

  test("should return server error when data source is unsuccessful.",
      () async {
    when(mockWeatherRemoteDataSource.getCurrentWeather("12.12", "12.12"))
        .thenThrow(ServerException());

    final result =
        await weatherRepositoryImpl.getCurrentWeather("12.12", "12.12");
    expect(result, equals(const Left(ServerFailure("Server Error!"))));
  });

  test("should return connection error when no internet connection.", () async {
    when(mockWeatherRemoteDataSource.getCurrentWeather("12.12", "12.12"))
        .thenThrow(const SocketException("Failed to connect to the network"));

    final result =
        await weatherRepositoryImpl.getCurrentWeather("12.12", "12.12");
    expect(
        result,
        equals(const Left(
            ConnectionFailure("Failure to connect to the network"))));
  });
}
