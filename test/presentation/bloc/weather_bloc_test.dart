import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_tdd/core/error/failure.dart';
import 'package:weather_app_tdd/data/models/weather_model.dart';
import 'package:weather_app_tdd/domain/entities/weather.dart';
import 'package:weather_app_tdd/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_tdd/presentation/bloc/weather_event.dart';
import 'package:weather_app_tdd/presentation/bloc/weather_state.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
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

  test("check initial state is empty", () {
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
      "should emit[WeatherLoading, WeatherLoaded] when successful response is get",
      build: () {
        when(mockGetCurrentWeatherUseCase.execute("12.12", "12.12"))
            .thenAnswer((realInvocation) async {
          return const Right(weatherEntity);
        });
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnLocationChanged("12.12", "12.12")),
      wait: const Duration(milliseconds: 500),
      expect: () => [WeatherLoading(), const WeatherLoaded(weatherEntity)]);

  blocTest<WeatherBloc, WeatherState>(
      "should emit[WeatherLoading, WeatherFailed] when get data is unsuccessful",
      build: () {
        when(mockGetCurrentWeatherUseCase.execute("12.12", "12.12"))
            .thenAnswer((realInvocation) async {
          return const Left(ServerFailure("Server Error"));
        });
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnLocationChanged("12.12", "12.12")),
      wait: const Duration(milliseconds: 500),
      expect: () => [WeatherLoading(), const WeatherFailure("Server Error")]);
}
