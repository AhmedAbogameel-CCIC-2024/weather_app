import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/core/datasources/weather.dart';
import 'package:weather_app/core/models/weather.dart';
import 'package:weather_app/views/home/states.dart';

import '../../core/location_utils/location_utils.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInit());

  final _weatherDatasource = WeatherDatasource();

  Weather? weather;

  Future<void> getWeatherByCoordinates({LatLng? value}) async {
    emit(HomeLoading());
    if (value == null) {
      value = await LocationUtils.getDeviceLocation();
      if (value == null) {
        emit(HomeInit());
        return;
      }
    }
    weather = await _weatherDatasource.getWeatherByCoordinates(
      latitude: value.latitude,
      longitude: value.longitude,
    );
    emit(HomeInit());
  }
}
