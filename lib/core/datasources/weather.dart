import 'package:weather_app/core/network_utils/network_utils.dart';

import '../models/weather.dart';

class WeatherDatasource {
  Future<Weather?> getWeatherByCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await NetworkUtils.get('weather?lat=$latitude&lon=$longitude');
      if (response.statusCode == 200) {
        return Weather.fromJson(response.data);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
    return null;
  }

  Future<Weather?> getWeatherByCity({
    required String city,
  }) async {
    try {
      final response = await NetworkUtils.get('weather?q=$city');
      if (response.statusCode == 200) {
        return Weather.fromJson(response.data);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
    return null;
  }
}