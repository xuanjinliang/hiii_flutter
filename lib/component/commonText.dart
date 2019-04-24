import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hiii_flutter/component/config.dart';

class CommonText extends StatelessWidget {
  final String msg;
  final int size;
  final Color color;
  final TextAlign align;
  final bool softWrap;
  final FontWeight weight;

  CommonText(this.msg,
      {Key key,
      this.size = 24,
      this.color = const Color.fromRGBO(187, 187, 187, 1),
      this.align = TextAlign.left,
      this.softWrap = false,
      this.weight = FontWeight.bold})
      : assert(msg != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      msg,
      textAlign: align,
      softWrap: softWrap,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color,
          fontSize: ScreenUtil.getInstance().setSp(size),
          fontFamily: Config.FONTFAMILY,
          fontWeight: weight,
          decoration: TextDecoration.none),
    );
  }
}
