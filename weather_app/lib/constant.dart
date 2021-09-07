import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'modal/weatherInfo.dart';

void getDay(String dt) {
  DateTime dd = DateTime.parse(dt);
  var day = DateFormat('EEE').format(dd);
  print(day);
}

 String getHour(int dt) {
    var dd = DateTime.fromMillisecondsSinceEpoch(dt);
    var hour = DateFormat('hh:mm').format(dd);
    print("this is hour " + hour.toString());
    return hour;
  }


String imgUrl = "http://openweathermap.org/img/wn/";

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.size,
    this.weatherInfo,
  }) : super(key: key);

  final Size size;
  final WeatherInfo weatherInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.35,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                weatherInfo.city,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey,
                ),
              ),
              Text(
                weatherInfo.day,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  weatherInfo.weather,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                Container(
                  height: size.width * 0.1,
                  width: size.width * 0.23,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Text(
                          "°c",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        left: 0,
                        child: Text(
                          '${weatherInfo.maxTemp}/${weatherInfo.minTemp}',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                  image: NetworkImage(
                    imgUrl + "${weatherInfo.img}@4x.png",
                  ),
                ),
                Container(
                  height: size.width * 0.27,
                  width: size.width * 0.30,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: -1,
                        child: Text(
                          "°c",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -2,
                        left: 0,
                        child: Text(
                          '${weatherInfo.temp}',
                          style: TextStyle(
                            fontSize: 85,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const TEST = [
  {
    "Time": "Now",
    "Desc": "Party Cloudy",
    "icon": "01d",
    "temp": "34",
  },
  {
    "Time": "12:00",
    "Desc": "Thunder",
    "icon": "01d",
    "temp": "34",
  },
  {
    "Time": "13:00",
    "Desc": "Clear",
    "icon": "01n",
    "temp": "34",
  },
  {
    "Time": "14:00",
    "Desc": "Party Cloudy",
    "icon": "01d",
    "temp": "34",
  },
  {
    "Time": "12:00",
    "Desc": "Thunder",
    "icon": "02d",
    "temp": "34",
  },
  {
    "Time": "Now",
    "Desc": "Party Cloudy",
    "icon": "01n",
    "temp": "34",
  },
  {
    "Time": "12:00",
    "Desc": "Thunder",
    "icon": "01d",
    "temp": "34",
  },
  {
    "Time": "12:00",
    "Desc": "Thunder",
    "icon": "01d",
    "temp": "34",
  },
  {
    "Time": "12:00",
    "Desc": "Thunder",
    "icon": "01d",
    "temp": "34",
  },
];
