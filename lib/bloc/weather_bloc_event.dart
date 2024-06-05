part of 'weather_bloc_bloc.dart';

abstract class WeatherBlocEvent extends Equatable {
  const WeatherBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherBlocEvent {
  final String cityName;

  const FetchWeather(this.cityName);

  @override
  List<Object> get props => [cityName];
}