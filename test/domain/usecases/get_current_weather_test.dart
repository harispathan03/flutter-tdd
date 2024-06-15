import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_tdd/domain/entities/weather.dart';
import 'package:weather_app_tdd/domain/usecases/get_current_weather.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  const weatherEntity = WeatherEntity(
      cityName: "New york",
      main: "main",
      description: "description",
      iconCode: "iconCode",
      temprature: 50,
      pressure: 5,
      humidity: 3);

  test("should get weather details from repository", () async {
    //arrange
    when(mockWeatherRepository.getCurrentWeather("12.12", "12.12"))
        .thenAnswer((_) async => const Right(weatherEntity));

    //act
    final result = await getCurrentWeatherUseCase.execute("12.12", "12.12");

    //assert
    expect(result, const Right(weatherEntity));
  });
}
