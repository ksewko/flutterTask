import 'dart:convert';
import 'weather_model.dart';
import 'package:http/http.dart' as http;

class DataAPI {
  Future<WeatherResponse> getWeather(String city) async {

    final queryParameters = {
      'q': city,
      'appid': 'f3ab5e4319ada1ef642636ef30ec559c',
      'units': 'imperial'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}
