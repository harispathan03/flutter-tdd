import 'package:dartz/dartz.dart';
import 'package:weather_app_tdd/core/error/failure.dart';
import 'package:weather_app_tdd/domain/entities/weather.dart';
import 'package:weather_app_tdd/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(this.weatherRepository);

  Future<Either<Failure, WeatherEntity>> execute(String lat, String long) {
    return weatherRepository.getCurrentWeather(lat, long);
  }
}
