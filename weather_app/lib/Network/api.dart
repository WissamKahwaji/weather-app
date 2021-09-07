import 'dart:convert';
import 'package:http/http.dart' as http;

class Network {
  final url =
      "http://api.openweathermap.org/data/2.5/forecast?id=292223&appid=ab67b4e1dbdf3ee132b805876bad003f&cnt=5&units=metric";

  getData() async {
    http.Response res = await http.get(url);
    return res;
  }
}
