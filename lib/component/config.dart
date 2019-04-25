import 'package:intl/intl.dart' as intl;
import 'package:geolocator/geolocator.dart';
import 'package:hiii_flutter/component/location.dart';

class Config {
  static const FONTFAMILY = 'PingFangSC-Regular';

  static Position POSITION;

  static formatTime(DateTime time) {
    return intl.DateFormat("dd MMM, yyyy").format(time).toString();
  }

  static getPosition() {
    Location().getLocation().then((res) => {POSITION = res});
  }
}
