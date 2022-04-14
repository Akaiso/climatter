import 'package:climatter/constants/api_key.dart';
import 'package:climatter/controller/location_controlls.dart';
import 'package:climatter/services/city_service.dart';
import 'package:climatter/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.yourNameLastBustop, required this.emailC, required this.passwordC })
      : super(key: key);
  final String yourNameLastBustop;
  final emailC;
  final passwordC;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
    getApiDataAndLocation();
  }

  FirebaseAuth sOut = FirebaseAuth.instance;

  dynamic lat = 0.0;
  dynamic long = 0.0;
  int temperature = 0;
  dynamic description;
  dynamic cityName;
  dynamic inputCityName;

  dynamic getApiDataAndLocation() async {
    Location location = Location();
    await location.getLocation();

    WeatherService weatherApi = WeatherService();
    await weatherApi.getWeatherApi(
        'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$kapiKey&units=metric');

    setState(() {
      lat = location.latitude;
      long = location.longitude;
      temperature = weatherApi.temperatures;
      description = weatherApi.descriptions;
      cityName = weatherApi.cityNames;
    });
  }

  dynamic getCityInfo() async {
    Location location = Location();
    await location.getLocation();
    CitySearchService citySearchService = CitySearchService();
    await citySearchService.getCitySearchName(
        'http://api.openweathermap.org/data/2.5/weather?q=$inputCityName&appid=$kapiKey&units=metric');

    setState(() {
      if (inputCityName != null) {
        lat = location.latitude;
        long = location.longitude;
        temperature = citySearchService.temperatures;
        description = citySearchService.descriptions;
        cityName = citySearchService.cityNames;
      } else {
        lat = '';
        long = '';
        temperature = 0;
        description = '';
        cityName = 'City name is required';
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          InkWell(
              onTap: () {
                sOut.signOut();
                Navigator.pop(context);


              },
              child: const Icon(Icons.close)),
          const SizedBox(width: 20.0),
        ],
        centerTitle: true,
        title: const Text(
          'CLIMATTER',
          style: TextStyle(fontSize: 15.0, letterSpacing: 5.0),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.black,
            backgroundBlendMode: BlendMode.color,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://images.news18.com/ibnlive/uploads/2021/07/1627056776_clouds-1200x800.jpg?impolicy=website&width=510&height=356'))),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: true,
          child: GestureDetector(
            child: Column(children: [
              Row(
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  const SizedBox(width: 40.0),
                  Text('Welcome: ${widget.yourNameLastBustop}',
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  const Icon(Icons.ac_unit, color: Colors.deepOrangeAccent),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 40.0,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    inputCityName = value;
                  },
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {
                          HapticFeedback.vibrate();
                          getCityInfo();
                        },
                        child: const Icon(Icons.arrow_forward_rounded,
                            size: 40.0, color: Colors.orangeAccent)),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    contentPadding: const EdgeInsets.only(top: 2.0, left: 30.0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    filled: true,
                    fillColor: Colors.white10,
                    hintText: "Search city e.g california",
                    hintStyle: const TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Column(
                children: [
                  // const SizedBox(height: 0.0),
                  //Text(long.toString()),
                  const SizedBox(height: 30.0),
                  Text(
                    '$cityName',
                    style: const TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  Text(
                    '${temperature.toString()} \u2103',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 70.0),
                  ),

                  const SizedBox(
                      // height: 10.0,
                      ),
                  Text(
                    '$description',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              Container(height: 3.0, width: 300, color: Colors.white12),
              const SizedBox(height: 30.0),
              const Text('Get weather info for your location',
                  style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white)),
              const SizedBox(height: 20.0),
              SizedBox(
                height: 100,
                width: 100.0,
                child: FloatingActionButton(
                  backgroundColor: Colors.lightBlue.shade700,
                  onPressed: () async {
                    HapticFeedback.vibrate();
                    await getApiDataAndLocation();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.location_on_outlined,
                        size: 40.0,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'TAP',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
