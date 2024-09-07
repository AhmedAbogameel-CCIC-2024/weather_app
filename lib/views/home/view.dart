import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/views/home/cubit.dart';
import 'package:weather_app/views/home/states.dart';
import 'package:weather_app/views/search/view.dart';

import '../../core/datasources/weather.dart';
import '../select_location/view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getWeatherByCoordinates(),
      child: Builder(
        builder: (context) {
          final cubit = BlocProvider.of<HomeCubit>(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Home'),
              actions: [
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectLocationView(
                        onSelected: (v) => cubit.getWeatherByCoordinates(value: v),
                      ),
                    ),
                  ),
                  icon: Icon(Icons.add_location),
                ),
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchView(),
                    ),
                  ),
                  icon: Icon(Icons.search),
                ),
              ],
            ),
            body: BlocBuilder<HomeCubit, HomeStates>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final weather = cubit.weather;
                if (weather == null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Something went wrong"),
                      ElevatedButton(
                        onPressed: cubit.getWeatherByCoordinates,
                        child: Text('Try Again'),
                      ),
                    ],
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status : ${weather.status}'),
                      SizedBox(height: 16),
                      Text('Temperature : ${weather.temp.toStringAsFixed(2)}'),
                      SizedBox(height: 16),
                      Text('Humidity : ${weather.humidity}%'),
                      SizedBox(height: 16),
                      Text('City : ${weather.city}'),
                      SizedBox(height: 16),
                      Text('Country : ${weather.country}'),
                      SizedBox(height: 16),
                      Text('Latitude : ${weather.latitude}'),
                      SizedBox(height: 16),
                      Text('Longitude: ${weather.longitude}'),
                    ],
                  ),
                );
              },
            ),
          );
        }
      ),
    );
  }
}
