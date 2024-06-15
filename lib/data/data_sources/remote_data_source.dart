// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_tdd/core/constants/constants.dart';
import 'package:weather_app_tdd/core/error/exception.dart';
import 'package:weather_app_tdd/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String lat, String long);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final http.Client client;
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String lat, String long) async {
    try {
      final response = await client.get(Uri.parse(Urls.getUrl(lat, long)));
      if (response.statusCode == 200) {
        return WeatherModel.fromMap(json.decode(response.body));
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw const NoResultFoundException();
    }
  }
}
