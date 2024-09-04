import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/datasources/weather.dart';
import 'package:weather_app/core/models/weather.dart';
import 'package:weather_app/views/home/states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInit());

  final _weatherDatasource = WeatherDatasource();

  Weather? currentWeather;

  Future<void> getCurrentWeather() async {
    emit(HomeLoading());
    final position = await getDeviceLocation();
    if (position == null) {
      emit(HomeInit());
      return;
    }
    currentWeather = await _weatherDatasource.getWeatherByCoordinates(
      latitude: position.latitude,
      longitude: position.longitude,
    );
    emit(HomeInit());
  }

  Future<Position?> getDeviceLocation() async {
    final status = await Geolocator.requestPermission();
    if (status != LocationPermission.always && status != LocationPermission.whileInUse) {
      /// TODO: Show Alert Dialog
      print("Location Permission Denied");
      return null;
    }
    final position = await Geolocator.getCurrentPosition();
    return position;
  }
}
