import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_tdd/domain/entities/weather.dart';
import 'package:weather_app_tdd/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_tdd/presentation/bloc/weather_event.dart';
import 'package:weather_app_tdd/presentation/bloc/weather_state.dart';
import 'package:weather_app_tdd/presentation/pages/weather_page.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    // Use below when there is error of http during testing
    // HttpOverrides.global = null;
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testWeather = WeatherEntity(
      cityName: "cityName",
      main: "main",
      description: "description",
      iconCode: "iconCode",
      temprature: 40,
      pressure: 12,
      humidity: 2);

  // testWidgets(
  //     "state should be changed from empty to loading when value is entered",
  //     (widgetTester) async {
  //   when(() => mockWeatherBloc.state).thenReturn(WeatherEmpty());
  //   await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));
  //   var textField = find.byType(TextField);
  //   expect(textField, findsOneWidget);
  //   await widgetTester.enterText(textField, "New York");
  //   await widgetTester.pump();
  //   expect(find.text("New York"), findsOneWidget);
  // });

  testWidgets("loading indicator should be displayed when state is loading",
      (widgetTester) async {
    when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());

    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("is data loaded when state is WeatherLoaded()",
      (widgetTester) async {
    when(() => mockWeatherBloc.state)
        .thenReturn(const WeatherLoaded(testWeather));

    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));
    expect(find.byKey(const Key("weather_data")), findsOneWidget);
  });
}
