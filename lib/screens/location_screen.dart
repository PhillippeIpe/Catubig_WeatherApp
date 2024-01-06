import 'package:flutter/material.dart';
import 'package:weatherapp/utilities/constants.dart';
import 'dart:convert';
import 'package:weatherapp/services/weather.dart';
import 'package:weatherapp/screens/city_screen.dart';


class LocationScreen extends StatefulWidget {
  LocationScreen(this.data, {super.key});
  String data;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = new WeatherModel();
  late double temp;
  late String city, desc,iconweather,messageweather,tempweather;
  String? NewCity = null, info = null;
  late int id;

  @override
  void initState() {
    super.initState();
    info = widget.data;
    updateData();
    updateWeather();
  }

  void updateData(){
    desc = jsonDecode(info.toString())['weather'][0]['description'];
    temp = jsonDecode(info.toString())['main']['temp'];
    id = jsonDecode(info.toString())['weather'][0]['id'];
    city = jsonDecode(info.toString())['name'];
  }

  void updateWeather(){
    try {
      updateData();
      tempweather = temp.toStringAsFixed(0) + '°';
      iconweather = weatherModel.getWeatherIcon(id);
      messageweather = weatherModel.getMessage(temp.toInt()) + " in $city";

    }catch(e){
      tempweather = 'Error';
      iconweather = '🤷‍';
      messageweather = 'No weather info found';

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        info = widget.data;
                        updateWeather();
                      });
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      NewCity = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      setState(() {
                        info = NewCity;
                        updateWeather();
                      });
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      tempweather,
                      style: kTempTextStyle,
                    ),
                    Text(
                      iconweather,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  messageweather,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


