import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app_tdd/domain/usecases/get_current_weather.dart';
import 'package:weather_app_tdd/presentation/bloc/weather_event.dart';
import 'package:weather_app_tdd/presentation/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  WeatherBloc(this.getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnLocationChanged>((event, emit) async {
      emit(WeatherLoading());
      final result =
          await getCurrentWeatherUseCase.execute(event.lat, event.long);
      result.fold((failure) {
        emit(WeatherFailure(failure.message ?? ""));
      }, (weatherEntity) {
        emit(WeatherLoaded(weatherEntity));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
