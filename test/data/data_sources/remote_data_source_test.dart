import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:weather_app_tdd/core/constants/constants.dart';
import 'package:weather_app_tdd/core/error/exception.dart';
import 'package:weather_app_tdd/data/data_sources/remote_data_source.dart';
import 'package:weather_app_tdd/data/models/weather_model.dart';

import '../../helper/json_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  group("get group weather", () {
    test("should return weather model when status code is 200", () async {
      when(mockHttpClient.get(Uri.parse(Urls.baseUrl))).thenAnswer((_) async {
        return http.Response(
            readJson('helper/dummy_data/dummy_weather_response.json'), 200);
      });

      final result = await weatherRemoteDataSourceImpl.getCurrentWeather(
          Urls.latitude, Urls.longitude);

      expect(result, isA<WeatherModel>());
    });

    test(
        "should return a server exception when there is status code 404 or other",
        () async {
      when(mockHttpClient
              .get(Uri.parse(Urls.getUrl(Urls.latitude, Urls.longitude))))
          .thenAnswer((_) async {
        return http.Response("Server exception", 404);
      });

      // [Note]: Testcase will not pass by using below method even if it is correct because throwsA() method works well with functions but not Future functions.
      // final result = await weatherRemoteDataSourceImpl.getCurrentWeather(
      //     Urls.latitude, Urls.longitude);
      // expect(result, throwsA(isA<ServerException>()));

      expect(
          () async => await weatherRemoteDataSourceImpl.getCurrentWeather(
              Urls.latitude, Urls.longitude),
          throwsA(isA<ServerException>()));
    });
  });
}
