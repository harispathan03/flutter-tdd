class Urls {
  static const String baseUrl =
      "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey";
  static const String apiKey = "9a79ffe01a10624235a8ce8a11a58b0d";
  static const String latitude = "23.0225";
  static const String longitude = "72.5714";

  static String getUrl(String lat, String long) {
    return "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey";
  }
}
