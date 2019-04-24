import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hiii_flutter/component/config.dart';
import 'package:hiii_flutter/component/commonText.dart';
import 'package:hiii_flutter/component/toast.dart';
import 'package:hiii_flutter/home/shateDataWidget.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(days: 1));
  int daysNight = 1;

  bool subtract = false;
  bool add = true;
  int adultsNum = 1;

  Future _selectDate(DateTime currentTime, DateTime start, DateTime end) async {
    assert(currentTime != null);
    assert(start != null);
    assert(end != null);

    DateTime picked = await showDatePicker(
        context: context,
        initialDate: currentTime,
        firstDate: start,
        lastDate: end);

    return picked;
  }

  changeDate(bool state) {
    if (state) {
      _selectDate(startTime, DateTime.now().subtract(Duration(days: 1)),
              endTime.subtract(Duration(days: 1)))
          .then((time) {
        if (time != null) {
          setState(() {
            startTime = time;
            changeNight();
          });
        }
      });
    } else {
      _selectDate(endTime, startTime.add(Duration(days: 1)),
              DateTime.now().add(Duration(days: 30)))
          .then((time) {
        if (time != null) {
          setState(() {
            endTime = time;
            changeNight();
          });
        }
      });
    }
  }

  changeNight() {
    setState(() {
      daysNight = endTime.difference(startTime).inDays;
    });
  }

  changeAdultsNum(bool state) {
    int num = adultsNum;

    num += (state ? -1 : 1);

    if (num <= 1) {
      num = 1;
      subtract = false;
    } else if (num >= 8) {
      num = 8;
      add = false;
    } else {
      subtract = true;
      add = true;
    }

    setState(() {
      adultsNum = num;
    });
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return SingleChildScrollView(
      physics: ShareDataWidget.of(context).bottom > 0 ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(34)),
        decoration: BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage('assets/images/homeBg.png'),
                fit: BoxFit.fitWidth
            )),
        child: Column(
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(684),
              height: ScreenUtil().setHeight(100),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(364),
                  bottom: ScreenUtil().setHeight(10)),
              padding:
              EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(10))),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(227, 241, 235, 1),
                        offset: Offset(0, 0),
                        blurRadius: 4.0,
                        spreadRadius: 2)
                  ]),
              child: Text("SEARCH HOTELS",
                  style: TextStyle(
                      color: Color.fromRGBO(2, 13, 33, 1),
                      fontSize: ScreenUtil.getInstance().setSp(36),
                      fontFamily: Config.FONTFAMILY,
                      decoration: TextDecoration.none)),
            ),
            Container(
              width: ScreenUtil().setWidth(684),
              alignment: Alignment.topCenter,
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(22)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(10))),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(227, 241, 235, 1),
                        offset: Offset(0, 0),
                        blurRadius: 4.0,
                        spreadRadius: 2)
                  ]),
              child: Column(
                children: <Widget>[
                  ContentList(
                      child: Row(
                        children: <Widget>[
                          ContentIcon(icons: Icons.place),
                          Container(
                            width: ScreenUtil().setWidth(531),
                            child: GestureDetector(
                                onTap: () {
                                  // Toast.show(context, '待开发');
                                  Navigator.pushNamed(context, "map");
                                },
                                child: CommonText('Which city are you going to',
                                    size: 30)),
                          )
                        ],
                      )),
                  ContentList(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ContentIcon(icons: Icons.event_note),
                            GestureDetector(
                                onTap: () => changeDate(true),
                                child: CommonText(Config.formatTime(startTime),
                                    size: 30, color: Color.fromRGBO(42, 42, 42, 1))),
                            Icon(Icons.remove,
                                color: Color.fromRGBO(42, 42, 42, 1),
                                size: ScreenUtil.getInstance().setSp(30)),
                            GestureDetector(
                                onTap: () => changeDate(false),
                                child: CommonText(Config.formatTime(endTime),
                                    size: 30, color: Color.fromRGBO(42, 42, 42, 1)))
                          ],
                        ),
                        CommonText('${daysNight} night',
                            size: 30, color: Color.fromRGBO(0, 134, 81, 1))
                      ],
                    ),
                  ),
                  ContentList(
                    child: Row(
                      children: <Widget>[
                        ContentIcon(icons: Icons.home),
                        Container(
                            width: ScreenUtil().setWidth(531),
                            child: TextField(
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromRGBO(42, 42, 42, 1),
                                fontSize: ScreenUtil.getInstance().setSp(30),
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(0),
                                  hintText: 'Hotel name',
                                  hintStyle: TextStyle(
                                      color:
                                      const Color.fromRGBO(187, 187, 187, 1),
                                      fontSize:
                                      ScreenUtil.getInstance().setSp(30),
                                      fontFamily: Config.FONTFAMILY,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none)),
                            ))
                      ],
                    ),
                  ),
                  ContentList(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ContentIcon(icons: Icons.person),
                            CommonText('Adults',
                                color: Color.fromRGBO(42, 42, 42, 1), size: 30)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.remove_circle),
                              color: subtract
                                  ? Color.fromRGBO(0, 134, 81, 1)
                                  : Color.fromRGBO(187, 187, 187, 1),
                              iconSize: ScreenUtil.getInstance().setSp(44),
                              onPressed: () => changeAdultsNum(true),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(41)),
                              child: CommonText('${adultsNum}',
                                  color: Color.fromRGBO(42, 42, 42, 1), size: 30,),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle),
                              color: add
                                  ? Color.fromRGBO(0, 134, 81, 1)
                                  : Color.fromRGBO(187, 187, 187, 1),
                              iconSize: ScreenUtil.getInstance().setSp(44),
                              onPressed: () => changeAdultsNum(false),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(46)),
              width: ScreenUtil().setWidth(359),
              height: ScreenUtil().setHeight(81),
              child: FlatButton(
                  color: Color.fromRGBO(0, 134, 81, 1),
                  child: Text('SEARCH',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil.getInstance().setSp(30),
                          fontFamily: Config.FONTFAMILY,
                          decoration: TextDecoration.none)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  onPressed: () {
                    Toast.show(context, '待开发');
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class ContentList extends StatelessWidget {
  final Widget child;

  ContentList({Key key, @required this.child})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: ScreenUtil().setWidth(600),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(32)),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: ScreenUtil().setWidth(2),
                  color: Color.fromRGBO(244, 244, 244, 1)))),
      child: child,
    );
  }
}

class ContentIcon extends StatelessWidget {
  final IconData icons;
  final int size;

  ContentIcon({Key key, @required this.icons, this.size = 36})
      : assert(icons != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: ScreenUtil.getInstance().setSp(size),
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(33)),
      child: Icon(
        icons,
        color: Color.fromRGBO(42, 42, 42, 1),
        size: ScreenUtil.getInstance().setSp(size),
      ),
    );
  }
}
