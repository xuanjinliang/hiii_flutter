import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import "dart:convert";
import 'dart:async';
import 'package:hiii_flutter/component/textFieldComp.dart';
import 'package:hiii_flutter/component/toast.dart';
import 'package:hiii_flutter/component/config.dart';
import 'package:hiii_flutter/component/localStorage.dart';
import 'package:hiii_flutter/model/account.dart';
import 'package:hiii_flutter/bottomNavigation.dart';
import 'package:hiii_flutter/component/commonText.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  bool alreadySaved = false;
  bool clickForget = false;

  String forgotButtonText = 'FORGOT PASSWORD';

  void record() {
    setState(() {
      alreadySaved = !this.alreadySaved;
      if (!alreadySaved) {
        LocalSrorage.removeItem('user');
      }
    });
  }

  void timeCount() {
    const _countBackwards = 60;
    setForget('${_countBackwards}s');

    DateTime _recordNowTime = DateTime.now();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      DateTime _nowTime = DateTime.now();

      int differ = ((_nowTime.millisecondsSinceEpoch -
                  _recordNowTime.millisecondsSinceEpoch) /
              1000)
          .round();

      if (differ >= _countBackwards) {
        timer.cancel();
        setForget('FORGOT PASSWORD');
        clickForget = false;
      } else {
        setForget('${(_countBackwards - differ)}s');
      }
    });
  }

  void setForget(String str) {
    setState(() {
      forgotButtonText = str;
    });
  }

  void recordForget() {
    clickForget = true;
    timeCount();
  }

  void init() {
    // 获取用户名与密码
    LocalSrorage.getItem('user').then((String userObj) {
      if (userObj != null) {
        Account account = Account.fromJson(json.decode(userObj));
        _userNameController.text = account.userName;
        _passwordController.text = account.password;
        record();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //初始化状态

    init();
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");

    init();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/loginBg.jpg'),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter))),
            SingleChildScrollView(
              physics: MediaQuery.of(context).viewInsets.bottom > 0 ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection: TextDirection.ltr,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil().setWidth(218),
                          bottom: ScreenUtil().setWidth(120)),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.cover)),
                      width: ScreenUtil().setWidth(268),
                      height: ScreenUtil().setWidth(170)),
                  Container(
                    width: ScreenUtil().setWidth(600),
                    child: Form(
                      key: _formKey,
                      autovalidate: false,
                      child: Column(
                        children: <Widget>[
                          TextFieldComp('EMAIL ADDRESS', _userNameController,
                              hint: 'Please enter the correct email address',
                              inputType: TextInputType.emailAddress,
                              validator: (v) {
                                return RegExp(
                                    r'\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}',
                                    caseSensitive: false)
                                    .hasMatch(v)
                                    ? null
                                    : '';
                              }),
                          TextFieldComp('PASSWORD', _passwordController,
                              hint: 'Password cannot be less than 6 digits',
                              obscureText: true, validator: (v) {
                                return v.trim().length > 5 ? null : '';
                              })
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(61)),
                    width: ScreenUtil().setWidth(600),
                    height: ScreenUtil().setHeight(40),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () => {this.record()},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                textDirection: TextDirection.ltr,
                                verticalDirection: VerticalDirection.down,
                                children: <Widget>[
                                  Container(
                                      width: ScreenUtil().setHeight(30),
                                      height: ScreenUtil().setHeight(30),
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: ScreenUtil().setWidth(2),
                                              color: Colors.white,
                                              style: BorderStyle.solid)),
                                      child: Container(
                                          margin: EdgeInsets.all(2),
                                          color: alreadySaved
                                              ? Colors.white
                                              : Colors.transparent)),
                                  CommonText('Keep me signed in',
                                      size: 24,
                                      color: Colors.white,
                                      weight: FontWeight.normal)
                                ],
                              ),
                            )),
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                              color: Color.fromRGBO(0, 169, 154, 1),
                              padding: EdgeInsets.all(0),
                              child: CommonText(
                                forgotButtonText,
                                align: TextAlign.center,
                                softWrap: false,
                                color: Colors.white,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                if (!clickForget) {
                                  this.recordForget();
                                  Toast.show(context,
                                      'Verification code has been sent to your email');
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                  Container(
                      width: ScreenUtil().setWidth(494),
                      height: ScreenUtil().setWidth(81),
                      child: FlatButton(
                          color: Color.fromRGBO(0, 134, 81, 1),
                          child: Text('SIGN IN',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil.getInstance().setSp(30),
                                  fontFamily: Config.FONTFAMILY,
                                  decoration: TextDecoration.none)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            if ((_formKey.currentState as FormState).validate()) {
                              if (this.alreadySaved) {
                                Map<String, String> user = <String, String>{
                                  'userName': _userNameController.text,
                                  'password': _passwordController.text
                                };
                                LocalSrorage.setItem('user', json.encode(user));
                              }

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                      transitionDuration:
                                      Duration(milliseconds: 1000),
                                      pageBuilder: (BuildContext con,
                                          Animation animation,
                                          Animation secodaryAnimation) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: BottomNavigation(),
                                        );
                                      }),
                                      (Route route) => false);

                              return;
                            }
                            Toast.show(context, 'Wrong account or password',
                                icons: Icons.error_outline);
                          })),
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setWidth(167)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textDirection: TextDirection.ltr,
                      verticalDirection: VerticalDirection.down,
                      children: <Widget>[
                        Container(
                            width: ScreenUtil().setWidth(220),
                            height: ScreenUtil().setWidth(40),
                            margin: EdgeInsets.only(bottom: 9),
                            child: FlatButton(
                              color: Color.fromRGBO(0, 169, 154, 1),
                              child: Text('SIGN UP',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil.getInstance().setSp(24),
                                      fontFamily: Config.FONTFAMILY,
                                      decoration: TextDecoration.none)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                Navigator.pushNamed(context, 'register');
                              },
                            )),
                        Text('Need an account?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil.getInstance().setSp(30),
                                fontFamily: Config.FONTFAMILY,
                                decoration: TextDecoration.none)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
