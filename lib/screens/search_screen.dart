import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_myapp_bloc/bloc/weather_bloc_bloc.dart';

import 'package:weather_myapp_bloc/data/my_data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  List<String> filteredCities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              style: const TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                hintText: 'Enter City Name',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              onChanged: (value) {
                setState(() {
                  query = value;
                  filteredCities = cities.where((city) {
                    return city.toLowerCase().contains(query.toLowerCase());
                  }).toList();
                });
              },
            ),
          ),
          Expanded(
            child: query.isEmpty
                ? const Center(
                    child: Text(
                    'Search City',
                    style: TextStyle(color: Colors.grey),
                  ))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: filteredCities.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            filteredCities[index],
                            style: const TextStyle(color: Colors.grey),
                          ),
                          onTap: () {
                            setState(() {
                              selectedCity = filteredCities[index];
                              BlocProvider.of<WeatherBlocBloc>(context)
                                  .add(FetchWeather(selectedCity));
                              Navigator.pop(context);
                            });
                          },
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
