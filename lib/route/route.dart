import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hiii_flutter/login/login.dart';
import 'package:hiii_flutter/register/register.dart';
import 'package:hiii_flutter/googleMap/mapPage.dart';

class CustomRoute {
  static routes() {
    return {"map": (context) => Map()};
  }

  static generateRoute(RouteSettings settings) {
    print(settings);
    switch (settings.name) {
      case 'login':
        return CupertinoPageRoute(
            builder: (context) => Login(), settings: settings);
      case 'register':
        return CupertinoPageRoute(
            builder: (context) => Register(), settings: settings);
    }
  }
}
