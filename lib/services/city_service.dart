import 'dart:convert';

import 'package:http/http.dart' as http;

class CitySearchService {

  dynamic temperatures = 0;
  dynamic temper;
  dynamic descriptions;
  dynamic cityNames;

  Future<dynamic> getCitySearchName(String url) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        dynamic body = response.body;
        dynamic cityInfo = jsonDecode(body);
        dynamic temper = await cityInfo['main']['temp'];
        temperatures = temper;
        descriptions = await cityInfo['weather'][0]['description'];
        cityNames = await cityInfo['name'];

      }
    } catch (e) {
      print(e);
    }
  }

}