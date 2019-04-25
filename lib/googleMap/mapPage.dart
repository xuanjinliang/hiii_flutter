import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:hiii_flutter/component/toast.dart';
import 'package:hiii_flutter/component/config.dart';
import 'package:hiii_flutter/component/location.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  Position userLocation = Config.POSITION;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Location().getLocation().then((res) => {
          setState(() {
            userLocation = res;
          })
        });
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();

    print('result-->${userLocation}');
    print('latitude-->${userLocation.latitude}');
    print('longitude-->${userLocation.longitude}');
    print('accuracy-->${userLocation.accuracy}');
    print('altitude-->${userLocation.altitude}');
    print('speed-->${userLocation.speed}');
    print('speedAccuracy-->${userLocation.speedAccuracy}');
    print('heading-->${userLocation.heading}');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
          target: LatLng(userLocation.latitude, userLocation.longitude),
          zoom: 8),
      rotateGesturesEnabled: true,
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    ));
  }

/*Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/
}
