//
// import 'package:flutter/cupertino.dart';
// import 'package:geolocator/geolocator.dart';
//
//
// class Location {
//   dynamic longitude;
//   dynamic latitude;
//
//   Future<dynamic> getLocation()  async {
//     try{
//       Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
//       // longitude = position.longitude;
//       // latitude = position.latitude;
//     }catch(e){
//       throw('Something went wrong');
//     }
//
//
import 'package:geolocator/geolocator.dart';



class Location {

  dynamic longitude;
  dynamic latitude;

  Future<dynamic> getLocation() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    latitude = position.latitude;
    longitude = position.longitude;
  }
}












// Future<dynamic> getLocation() async {
//   try {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.low);
//  longitude = position.longitude;
//  latitude = position.latitude;
//   }
//   catch (e) {
//     throw('something went wrong');
//   }
// }
// }







