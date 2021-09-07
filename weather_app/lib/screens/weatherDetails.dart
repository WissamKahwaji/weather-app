import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:weather_app/modal/weatherInfo.dart';
import 'package:weather_app/constant.dart';
import 'package:http/http.dart' as http;

class WeatherDet extends StatefulWidget {
  final WeatherInfo weatherInfo;

  const WeatherDet({Key key, this.weatherInfo}) : super(key: key);

  @override
  _WeatherDetState createState() => _WeatherDetState();
}

List data = TEST;
int dt;

class _WeatherDetState extends State<WeatherDet> {
  Future getData() async {
    http.Response res = await http.get(
        "http://api.openweathermap.org/data/2.5/onecall/timemachine?lat=${widget.weatherInfo.lat}&lon=${widget.weatherInfo.lon}&dt=${tt()}&appid=ab67b4e1dbdf3ee132b805876bad003f&units=metric");
    var body = jsonDecode(res.body);
    
    return body;
  }

  int tt() {
    var ms = (new DateTime.now()).millisecondsSinceEpoch;
    print((ms / 1000).round());
    return (ms / 1000).round();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    getData();
    dt = tt();
    
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    size: size,
                    weatherInfo: widget.weatherInfo,
                  ),
                  Container(
                    height: size.height * 0.6,
                    width: size.width,
                    child: FutureBuilder(
                      future: getData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data['hourly'].length,
                            itemBuilder: (context, i) {
                              return Container(
                                width: size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Image(
                                          image: NetworkImage(
                                              "http://openweathermap.org/img/wn/${snapshot.data['hourly'][i]['weather'][0]['icon']}.png"),
                                        ),
                                        Text(
                                          getHour(
                                              snapshot.data['hourly'][i]['dt']),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Text(
                                          ' .',
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Text(
                                          ' ${snapshot.data['hourly'][i]['weather'][0]['main']}',
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      (snapshot.data['hourly'][i]['temp']
                                                  .toInt())
                                              .toString() +
                                          "°",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
