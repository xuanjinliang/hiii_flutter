import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hiii_flutter/component/commonText.dart';
import 'package:hiii_flutter/component/toast.dart';

class User extends StatefulWidget {
  User({Key key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: CommonText("MY", size: 34, color: Colors.white),
          centerTitle: true,
          elevation: 0,
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Positioned(
              child: Container(
                height: ScreenUtil().setHeight(82),
                color: Color.fromRGBO(0, 134, 81, 1),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(15),
                      bottom: ScreenUtil().setHeight(30)),
                  width: ScreenUtil().setWidth(700),
                  height: ScreenUtil().setWidth(180),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(227, 241, 235, 1),
                            offset: Offset(0, 2),
                            blurRadius: 2.0,
                            spreadRadius: 1)
                      ]),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setWidth(588),
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(34),
                            bottom: ScreenUtil().setHeight(23)),
                        child: CommonText("Hi，Apinya Hinnon",
                            color: Color.fromRGBO(49, 49, 49, 1),
                            size: 40,
                            softWrap: true),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(588),
                        child: CommonText("732937648@qq.com",
                            size: 30, softWrap: true),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(25),
                      horizontal: ScreenUtil().setWidth(50)),
                  width: ScreenUtil().setWidth(700),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(227, 241, 235, 1),
                            offset: Offset(0, 2),
                            blurRadius: 2.0,
                            spreadRadius: 1)
                      ]),
                  child: Column(
                    children: <Widget>[
                      Item("My Account", icon: Icons.assignment_ind),
                      Item("Sign Out", icon: Icons.exit_to_app),
                      Item("My Suggestions", icon: Icons.insert_comment, bottomLine: false),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(158)),
                  width: ScreenUtil().setWidth(494),
                  height: ScreenUtil().setHeight(81),
                  child: FlatButton(
                      color: Color.fromRGBO(187,187,187,1),
                      child: CommonText("SIGN OUT", size: 30, color: Colors.white),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      onPressed: () {
                        Toast.show(context, '待开发');
                      }),
                )
              ],
            )
          ],
        ));
  }
}

class Item extends StatelessWidget {
  final String msg;
  final IconData icon;
  final bool bottomLine;

  Item(this.msg, {Key key, @required this.icon, this.bottomLine = true})
      : assert(msg != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {

    Border bottomBorder = bottomLine ? Border(
        bottom: BorderSide(
            width: ScreenUtil().setHeight(2),
            color: Color.fromRGBO(245, 245, 245, 1))) : null;

    // TODO: implement build
    return Container(
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(36),
            bottom: ScreenUtil().setHeight(30)),
        width: ScreenUtil().setWidth(600),
        decoration: BoxDecoration(
            border: bottomBorder),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(6),
                  right: ScreenUtil().setWidth(26)),
              child: Icon(icon,
                  size: ScreenUtil.getInstance().setSp(40)),
            ),
            Container(
              width: ScreenUtil().setWidth(478),
              child: CommonText(msg,
                  size: 30,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  softWrap: true),
            ),
            Container(
              width: ScreenUtil().setWidth(50),
              child: Icon(Icons.arrow_forward_ios,
                  size: ScreenUtil.getInstance().setSp(30),
                  color: Color.fromRGBO(0, 0, 0, 0.15)),
            ),
          ],
        ));
  }
}
