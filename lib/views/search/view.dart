import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/views/home/cubit.dart';
import 'package:weather_app/views/home/states.dart';

import '../../core/datasources/weather.dart';
import 'cubit.dart';
import 'states.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text('Search')),
        body: BlocBuilder<SearchCubit, SearchStates>(
          builder: (context, state) {
            final cubit = BlocProvider.of<SearchCubit>(context);
            final weather = cubit.weather;
            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: cubit.searchTXController,
                        decoration: InputDecoration(
                          label: Text('Enter City'),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    IconButton(
                      onPressed: cubit.search,
                      icon: Icon(Icons.search),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Builder(
                  builder: (context) {
                    if (state is SearchLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (weather == null) {
                      return Center(child: Text("No Results"));
                    }
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Status : ${weather.status}'),
                          SizedBox(height: 16),
                          Text(
                              'Temperature : ${weather.temp.toStringAsFixed(2)}'),
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
              ],
            );
          },
        ),
      ),
    );
  }
}
