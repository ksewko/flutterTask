import 'package:flutter/material.dart';
import 'package:flutter_task/model/location_model.dart';
import 'package:flutter_task/model/weather_api.dart';
import 'package:flutter_task/model/weather_model.dart';
import 'package:flutter_task/widgets/loc_widget.dart';

import 'model/location_helper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  String _cityName;
  final _dataService = DataAPI();

  WeatherResponse _response;

  LocationModel _locationPicked;

  void _selectLocation(double latitude, double longitude) {
    _locationPicked = LocationModel(latitude: latitude, longitude: longitude);
  }

  @override
  Widget build(BuildContext context) {
    String bgImage = 'bg.png';
    Color mainColor = Colors.deepPurple;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Zadanie Flutter'),
        backgroundColor: mainColor,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: FlatButton.icon(
                      height: 50.0,
                      onPressed: () async {
                        dynamic result =
                            await Navigator.pushNamed(context, '/poland');
                      },
                      icon: Icon(
                        Icons.map,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Mapa Polski',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      shape: StadiumBorder(),
                    ),
                  ),
                ],
              ),
              LocWidget(_selectLocation),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    height: 40.0,
                    child: FlatButton(
                      onPressed: _generateLocWeather,
                      child: Text(
                        'Pokaż pogodę',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      color: mainColor,
                      shape: StadiumBorder(),
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_cityName != null)
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Miasto: ${_cityName}",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_response != null)
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(_response.iconUrl),
                            Column(
                              children: [
                                Text(
                                  '${((_response.tempInfo.temperature - 32) / 1.8).toStringAsFixed(1)}°C',
                                  style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Text(
                                    'Wilgotność ${_response.tempInfo.humidity}%',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _generateLocWeather() async {
    final String locationName = await LocationHelper.getLocationName(
        _locationPicked.latitude, _locationPicked.longitude);
    int index1 = locationName.indexOf(',', locationName.indexOf(',') + 1) + 2;
    String temp = locationName.substring(index1, locationName.lastIndexOf(','));
    String finalName =
        temp.substring(temp.indexOf(',') + 2, temp.lastIndexOf(' '));
    print(finalName);

    _cityName = finalName;
    final response = await _dataService.getWeather(finalName);
    setState(() => _response = response);
  }
}
