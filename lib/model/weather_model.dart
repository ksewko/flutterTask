class WeatherInfo {
  final String icon;

  WeatherInfo({this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final icon = json['icon'];
    return WeatherInfo(icon: icon);
  }
}

class TemperatureInfo {
  final double temperature;
  final int humidity;

  TemperatureInfo({this.temperature, this.humidity});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    final humidity = json['humidity'];
    return TemperatureInfo(temperature: temperature, humidity: humidity);
  }
}

class WeatherResponse {
  final String cityName;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse({this.cityName, this.tempInfo, this.weatherInfo});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    return WeatherResponse(
        cityName: cityName, tempInfo: tempInfo, weatherInfo: weatherInfo);
  }
}
