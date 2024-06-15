// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String cityName;
  final String main;
  final String description;
  final String iconCode;
  final double temprature;
  final int pressure;
  final int humidity;
  const WeatherEntity({
    required this.cityName,
    required this.main,
    required this.description,
    required this.iconCode,
    required this.temprature,
    required this.pressure,
    required this.humidity,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [cityName, main, description, iconCode, temprature, pressure, humidity];
}
