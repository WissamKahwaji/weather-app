import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/constant.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/modal/weatherInfo.dart';
import 'package:weather_app/screens/weatherDetails.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

String apiKey = "ab67b4e1dbdf3ee132b805876bad003f";
DateTime now = DateTime.now();
String city;
String day;
String weather;
String temp;
String mintemp;
String maxtemp;
String icon;
int dt;
DateTime dateTime;
double lat;
double lon;

class _WeatherState extends State<Weather> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var dd = DateFormat('EEE dd/MM/yyyy').format(now);
    day = dd;
    
  }

  String getDay(String dt) {
    DateTime dd = DateTime.parse(dt);
    var day = DateFormat('EEE').format(dd);
    
    return day;
  }

  String getMonth(String dt) {
    DateTime dd = DateTime.parse(dt);
    var day = DateFormat('dd/MM').format(dd);
   
    return day;
  }

  Future getData() async {
    http.Response res = await http.get(
        "http://api.openweathermap.org/data/2.5/forecast?id=292223&appid=ab67b4e1dbdf3ee132b805876bad003f&cnt=5&units=metric");
    var body = jsonDecode(res.body);
   

    city = body['city']['name'];
    dt = body['list'][0]['dt'];
    lat = body['city']['coord']['lat'];
    lon = body['city']['coord']['lon'];

    weather = body['list'][0]['weather'][0]['main'].toString();
    icon = body['list'][0]['weather'][0]['icon'].toString();
    mintemp = ((body['list'][0]['main']['temp_min']).toInt()).toString();
    maxtemp = ((body['list'][0]['main']['temp_max']).toInt()).toString();
    int t = (body['list'][0]['main']['temp']).toInt();

    temp = t.toString();
    
    return body;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(
                        size: size,
                        weatherInfo: WeatherInfo(
                          city: city,
                          day: day,
                          weather: weather,
                          maxTemp: maxtemp,
                          minTemp: mintemp,
                          img: icon,
                          temp: temp,
                        ),
                      ),
                      Text(
                        '5-days Forecast',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[800],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, i) {
                            return GestureDetector(
                              child: Container(
                                margin: EdgeInsets.only(top: 20.0, right: 15.0),
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.grey[200],
                                ),
                                width: size.width * 0.2,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      getDay(snapshot.data['list'][i]['dt_txt']
                                          .toString()),
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Text(
                                      getMonth(snapshot.data['list'][i]
                                              ['dt_txt']
                                          .toString()),
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Image(
                                      image: NetworkImage(imgUrl +
                                          "${snapshot.data['list'][i]['weather'][0]['icon']}.png"),
                                    ),
                                    Text(
                                      snapshot.data['list'][i]['weather'][0]
                                              ['main']
                                          .toString(),
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Text(
                                      ((snapshot.data['list'][0]['main']
                                                      ['temp_max'])
                                                  .toInt())
                                              .toString() +
                                          "/" +
                                          ((snapshot.data['list'][0]['main']
                                                      ['temp_min'])
                                                  .toInt())
                                              .toString(),
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                WeatherInfo weatherInfo = WeatherInfo(
                                    city: city,
                                    dt: dt,
                                    dateTime: DateTime.parse(
                                        snapshot.data['list'][i]['dt_txt']),
                                    lat: lat,
                                    lon: lon,
                                    day: day,
                                    weather: weather,
                                    temp: temp,
                                    maxTemp: maxtemp,
                                    minTemp: mintemp,
                                    img: snapshot.data['list'][i]['weather'][0]
                                            ['icon']
                                        .toString());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WeatherDet(
                                      weatherInfo: weatherInfo,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
