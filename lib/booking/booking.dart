import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hiii_flutter/component/config.dart';
import "dart:convert";
import 'package:hiii_flutter/component/commonText.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hiii_flutter/model/booking_list.dart';
import 'package:hiii_flutter/component/toast.dart';

class Booking extends StatefulWidget {
  Booking({Key key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {

  ScrollController _controller = new ScrollController();
  bool loadFile = false;

  List<DataEntity> dataList = [];

  Future<String> readJsonList() async {
    return await rootBundle.loadString('assets/json/bookingList.json');
  }

  void setJsonFile() {
    readJsonList().then((myjson) {
      BookingList obj = BookingList.fromJson(json.decode(myjson));
      if(mounted){
        setState(() {
          dataList.addAll(obj.data);
          loadFile = false;
        });
      }
    });
  }

  void retrieveData() {
    if(loadFile){
      return;
    }
    loadFile = true;
    Future.delayed(Duration(seconds: 1)).then((e) {
      setJsonFile();
    });
  }

  List<Widget> getWidgetsList(List<DataEntity> list) {
    if (list != null && list.length > 0) {
      return list.map((o) => Item(o)).toList();
    }
    return [];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setJsonFile();

    _controller.addListener(() {
      if(_controller.position.pixels >= _controller.position.maxScrollExtent - 10 && dataList.length < 20) {
        retrieveData();
      }
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    //setJsonFile();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: CommonText("MY BOOKING (5)", size: 34, color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: dataList.length + 1,
          //itemExtent: ScreenUtil().setHeight(453),
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            // return ListTile(title: Text("$index"));

            if (index >= dataList.length) {
              if (dataList.length < 20) {
                //retrieveData();
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: CircularProgressIndicator(strokeWidth: 2.0)),
                );
              }else {
                return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16.0),
                    child: CommonText("No more")
                );
              }
            }

            return Item(dataList[index]);
          }),
      /*body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(33)),
          child: Column(
            children: getWidgetsList(dataList),
          ),
        )*/
    );
  }
}

class CardState extends StatelessWidget {
  final int state;

  Map<String, Color> stateColor({num = 0}) {
    List<Map<String, Color>> list = [
      {"Vaild": Color.fromRGBO(127, 196, 90, 1)},
      {"Processing": Color.fromRGBO(100, 158, 255, 1)},
      {"Failed": Color.fromRGBO(255, 100, 108, 1)}
    ];

    return list[num];
  }

  CardState(this.state, {Key key})
      : assert(state != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Map map = stateColor(num: state);

    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setWidth(9),
          horizontal: ScreenUtil().setWidth(31)),
      margin: EdgeInsets.only(
          bottom: ScreenUtil().setWidth(3), left: ScreenUtil().setWidth(9)),
      constraints: BoxConstraints(
        maxWidth: ScreenUtil().setWidth(253),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: map.values.first,
      ),
      child: CommonText(map.keys.first, color: Colors.white, softWrap: true),
    );
  }
}

class DetailButton extends StatelessWidget {
  final String msg;
  final int state;
  final String orderId;

  DetailButton(this.msg, {Key key, this.state = 0, @required this.orderId})
      : assert(msg != null),
        assert(orderId != null),
        super(key: key);

  stateColor({num = 0}) {
    List<Color> list = [
      Color.fromRGBO(0, 134, 81, 1),
      Color.fromRGBO(187, 187, 187, 1)
    ];
    return list[num];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.only(
            left: ScreenUtil().setWidth(19),
            top: ScreenUtil().setWidth(22),
            bottom: ScreenUtil().setWidth(17)),
        height: ScreenUtil().setWidth(50),
        child: FlatButton(
          onPressed: () {
            print(orderId);
            Toast.show(context, '订单号：${orderId}');
          },
          splashColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(45)),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: stateColor(num: state)),
              borderRadius: BorderRadius.circular(40.0)),
          child: CommonText(msg, color: stateColor(num: state)),
        ));
  }
}

class Item extends StatelessWidget {
  final DataEntity data;

  Item(this.data, {Key key})
      : assert(data != null),
        super(key: key);

  String formatDate(String str) {
    return Config.formatTime(
        DateTime.fromMillisecondsSinceEpoch(int.parse(str) * 1000));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: ScreenUtil().setWidth(684),
        height: ScreenUtil().setWidth(403),
        margin: EdgeInsets.only(
            left: ScreenUtil().setWidth(33),
            right: ScreenUtil().setWidth(33),
            top: ScreenUtil().setWidth(30),
            bottom: ScreenUtil().setWidth(20)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(227, 241, 235, 1),
                  offset: Offset(0, 0),
                  blurRadius: 4.0,
                  spreadRadius: 2)
            ]),
        child: Container(
          width: ScreenUtil().setWidth(636),
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(25),
              right: ScreenUtil().setWidth(23),
              top: ScreenUtil().setHeight(33)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(374),
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(9)),
                    margin: EdgeInsets.only(top: ScreenUtil().setWidth(6)),
                    child: CommonText(data.title,
                        size: 36,
                        color: Color.fromRGBO(0, 55, 33, 1),
                        softWrap: true),
                  ),
                  CardState(data.state)
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(9)),
                margin: EdgeInsets.only(
                    top: ScreenUtil().setWidth(22),
                    bottom: ScreenUtil().setWidth(25)),
                width: ScreenUtil().setWidth(431),
                child: CommonText(data.describe,
                    size: 30, softWrap: true, weight: FontWeight.w400),
              ),
              Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(9)),
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(22)),
                width: ScreenUtil().setWidth(374),
                child: CommonText("Check-in: ${formatDate(data.startTime)}",
                    size: 30,
                    color: Color.fromRGBO(59, 59, 59, 1),
                    softWrap: true,
                    weight: FontWeight.w400),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(9)),
                    width: ScreenUtil().setWidth(374),
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setWidth(3),
                        bottom: ScreenUtil().setWidth(33)),
                    child: CommonText("Check-out: ${formatDate(data.endTime)}",
                        size: 30,
                        color: Color.fromRGBO(59, 59, 59, 1),
                        softWrap: true,
                        weight: FontWeight.w400),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(36)),
                    constraints: BoxConstraints(
                      maxWidth: ScreenUtil().setWidth(253),
                    ),
                    child: CommonText("${data.money} USD",
                        size: 36,
                        color: Color.fromRGBO(220, 154, 60, 1),
                        softWrap: true),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: Color.fromRGBO(187, 187, 187, 1),
                            width: ScreenUtil().setHeight(1)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    DetailButton("Cancel your booking",
                        state: 1, orderId: data.orderId),
                    DetailButton("Booking details", orderId: data.orderId)
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
