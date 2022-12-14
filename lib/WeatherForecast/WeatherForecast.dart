import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TempModel {
  final double temp;
  final double feels_like;

  TempModel({
    required this.temp,
    required this.feels_like,
  });

  factory TempModel.fromJson(Map<String, dynamic> json) {
    return TempModel(
      temp: json['temp'],
      feels_like: json['feels_like'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['temp'] = temp;
    data['feels_like'] = feels_like;

    return data;
  }
}

class DescriptionModel<List> {
  final String description;
  final String icon;

  DescriptionModel({
    required this.description,
    required this.icon,
  });

  factory DescriptionModel.fromJson(Map<String, dynamic> json) {
    return DescriptionModel(
      description: json['description'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['description'] = description;
    data['icon'] = icon;

    return data;
  }
}

class WeatherModel {
  final TempModel main;
  final List<DescriptionModel> weather;

  WeatherModel({
    required this.main,
    required this.weather,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      main: TempModel.fromJson(json['main']),
      weather: (json['weather'] as List<dynamic>)
          .map((i) => DescriptionModel.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['main'] = main;
    data['weather'] = weather;
    return data;
  }
}

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({Key? key}) : super(key: key);
  Future<WeatherModel?> fetchWeather(String sehir) async {
    print(sehir);
    final http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$sehir&units=metric&appid=666319c58bc57caab32599c61b82c50e'));
    print(response.body);
    try {
      if (response.statusCode == 200) {
        WeatherModel weatherModel =
            WeatherModel.fromJson(jsonDecode(response.body));
        return weatherModel;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString(), name: "error");
      return null;
    }
  }

  final String sehir1 = 'İstanbul';
  final String sehir2 = 'Ankara';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Türkiye Weather Forecast'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FutureBuilder(
                  future: fetchWeather(sehir1),
                  builder: (ctx, AsyncSnapshot<WeatherModel?> snapshot) {
                    if (!snapshot.hasData || snapshot.hasError) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      String icon = snapshot.data!.weather[0].icon;
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                'http://openweathermap.org/img/wn/$icon.png'),
                            Text('$sehir1 weather forecast'),
                            Text(
                                'Situation: ${snapshot.data!.weather[0].description}'),
                            Text(
                                'Temperature: ${snapshot.data!.main.temp.toString()} °C'),
                            Text(
                                'Sensible temperature: ${snapshot.data!.main.feels_like.toString()} °C'),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FutureBuilder(
                  future: fetchWeather(sehir2),
                  builder: (ctx, AsyncSnapshot<WeatherModel?> snapshot) {
                    if (!snapshot.hasData || snapshot.hasError) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      String icon = snapshot.data!.weather[0].icon;
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                'http://openweathermap.org/img/wn/$icon.png'),
                            Text('$sehir2 weather forecast'),
                            Text(
                                'Situation: ${snapshot.data!.weather[0].description}'),
                            Text(
                                'Temperature: ${snapshot.data!.main.temp.toString()} °C'),
                            Text(
                                'Sensible temperature: ${snapshot.data!.main.feels_like.toString()} °C'),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
