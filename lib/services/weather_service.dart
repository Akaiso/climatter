import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService{

  dynamic temperatures ;
  dynamic descriptions;
  dynamic cityNames;
  dynamic temper;


  Future<dynamic> getWeatherApi(String url) async{

    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode <= 200) {
        print(response.body);
        dynamic data = response.body;
        dynamic decodedData = jsonDecode(data);

        temper = await decodedData['main']['temp'];
        temperatures = temper.toInt();
        descriptions = await decodedData['weather'][0]['description'];
        cityNames = await decodedData['name'];
      } else {
      }
    }catch(e){throw(e);}
  }




}