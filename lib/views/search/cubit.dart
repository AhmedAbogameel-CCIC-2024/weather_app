import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/datasources/weather.dart';
import 'package:weather_app/core/models/weather.dart';
import 'package:weather_app/views/search/states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInit());

  final _weatherDatasource = WeatherDatasource();

  final searchTXController = TextEditingController();
  Weather? weather;

  Future<void> search() async {
    if (searchTXController.text.trim().isEmpty) {
      return;
    }
    emit(SearchLoading());
    weather = await _weatherDatasource.getWeatherByCity(
      city: searchTXController.text,
    );
    emit(SearchInit());
  }

  @override
  Future<void> close() {
    searchTXController.dispose();
    return super.close();
  }
}
