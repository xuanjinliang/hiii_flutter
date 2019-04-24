import 'package:intl/intl.dart' as intl;

class Config {
  static const FONTFAMILY = 'PingFangSC-Regular';

  static formatTime(DateTime time) {
    return intl.DateFormat("dd MMM, yyyy").format(time).toString();
  }
}