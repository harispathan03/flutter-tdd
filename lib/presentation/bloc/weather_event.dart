import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class OnLocationChanged extends WeatherEvent {
  final String lat;
  final String long;

  const OnLocationChanged(this.lat, this.long);

  @override
  List<Object?> get props => [lat, long];
}
