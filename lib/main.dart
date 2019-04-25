import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hiii_flutter/component/config.dart';
import 'package:hiii_flutter/route/route.dart';
import 'package:hiii_flutter/login/login.dart';
import 'package:hiii_flutter/component/commonText.dart';

void main(){
  Config.getPosition();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.green,
          primaryColor: Color.fromRGBO(0, 134, 81, 1)),
      routes: CustomRoute.routes(),
      onGenerateRoute: (RouteSettings settings) =>
          CustomRoute.generateRoute(settings),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const _countBackwards = 3;
  int setCount = _countBackwards;
  bool jump = false;
  BuildContext splashContext;

  void changeCount(num) {
    setState(() {
      setCount = num;
    });
  }

  void timeCount() {
    DateTime _recordNowTime = DateTime.now();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      DateTime _nowTime = DateTime.now();

      int differ = ((_nowTime.millisecondsSinceEpoch -
                  _recordNowTime.millisecondsSinceEpoch) /
              1000)
          .round();

      if (differ >= _countBackwards) {
        timer.cancel();
        //Navigator.pushReplacementNamed(splashContext, "login");
        Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 1000),
                pageBuilder: (BuildContext con, Animation animation,
                    Animation secodaryAnimation) {
                  return FadeTransition(
                    opacity: animation,
                    child: Login(),
                  );
                }),
            (Route route) => false);
      } else {
        changeCount(_countBackwards - differ);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    setCount = _countBackwards;
  }

  @override
  Widget build(BuildContext context) {
    splashContext = context;

    //解决flutter初始始化时，没有获取到宽度与高度
    if (ScreenUtil.screenWidthDp == null || ScreenUtil.screenWidthDp <= 0) {
      ScreenUtil.instance =
          ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
            ..init(context);
    }

    if (!jump) {
      jump = true;
      Timer.run(timeCount);
    }

    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/loginBg.jpg'),
              fit: BoxFit.cover)),
      child: Center(
        child: Container(
            width: ScreenUtil().setWidth(100),
            height: ScreenUtil().setWidth(100),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1, style: BorderStyle.solid, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Color.fromRGBO(255, 255, 255, 0.1),
            ),
            child: CommonText(setCount.toString(),
                align: TextAlign.center, color: Colors.white, size: 48)),
      ),
    );
  }
}
