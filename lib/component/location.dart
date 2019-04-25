import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';

class Location {

  Geolocator geolocator = Geolocator();

  static Location cache;

  factory Location() {
    if(Location.cache == null){
      Location.cache = Location._internal();
    }
    return Location.cache;
  }

  Location._internal();

  Future<Position> getLocation() async {
    Position currentLocation;

    // 这里可以判断用户定位是否不可用
    /*GeolocationStatus permission = await geolocator.checkGeolocationPermissionStatus();
    print(permission);*/

    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } on PlatformException catch (e) {
      print('e-->${e}');
      currentLocation = null;
    }

    return currentLocation;
  }
}