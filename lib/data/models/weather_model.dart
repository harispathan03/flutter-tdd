import 'package:weather_app_tdd/domain/entities/weather.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel(
      {required super.cityName,
      required super.main,
      required super.description,
      required super.iconCode,
      required super.temprature,
      required super.pressure,
      required super.humidity});

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      cityName: map['name'],
      main: map['weather'][0]['main'],
      description: map['weather'][0]['description'],
      iconCode: map['weather'][0]['icon'],
      temprature: map['main']['temp'],
      pressure: map['main']['pressure'],
      humidity: map['main']['humidity'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'weather': [
        {
          'main': main,
          'description': description,
          'icon': iconCode,
        }
      ],
      'main': {
        'temp': temprature,
        'pressure': pressure,
        'humidity': humidity,
      },
      'name': cityName,
    };
  }

  WeatherEntity toEntity() => WeatherEntity(
      cityName: cityName,
      main: main,
      description: description,
      iconCode: iconCode,
      temprature: temprature,
      pressure: pressure,
      humidity: humidity);
}
