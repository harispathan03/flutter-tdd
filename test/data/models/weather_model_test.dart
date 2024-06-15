import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_tdd/data/models/weather_model.dart';
import 'package:weather_app_tdd/domain/entities/weather.dart';

import '../../helper/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
      cityName: "Ahmedabad",
      main: "Clouds",
      description: "scattered clouds",
      iconCode: "03d",
      temprature: 311.17,
      pressure: 1002,
      humidity: 32);

  test("should be a subclass of weather entity", () {
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test("should return a valid model from json", () async {
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helper/dummy_data/dummy_weather_response.json'));

    final result = WeatherModel.fromMap(jsonMap);

    expect(result, equals(testWeatherModel));
  });

  test("should return a json map containing proper data", () {
    final result = testWeatherModel.toMap();

    const expectedJsonResult = {
      'weather': [
        {
          'main': "Clouds",
          'description': "scattered clouds",
          'icon': "03d",
        }
      ],
      'main': {
        'temp': 311.17,
        'pressure': 1002,
        'humidity': 32,
      },
      'name': "Ahmedabad",
    };

    expect(result, expectedJsonResult);
  });
}
