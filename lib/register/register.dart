import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:hiii_flutter/component/textFieldComp.dart';
import 'package:hiii_flutter/component/toast.dart';
import 'package:hiii_flutter/component/config.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/loginBg.jpg'),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter)),
        ),
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
                    bottom: ScreenUtil().setWidth(145)),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.cover)),
                width: ScreenUtil().setWidth(268),
                height: ScreenUtil().setWidth(170),
              ),
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
                      }),
                      TextFieldComp(
                          'CONFIRM PASSWORD', _confirmPasswordController,
                          hint: 'Must be consistent with the password',
                          obscureText: true, validator: (v) {
                        return v.trim().length > 5 &&
                                v.trim() == _passwordController.text.trim()
                            ? null
                            : '';
                      })
                    ],
                  ),
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(494),
                height: ScreenUtil().setHeight(81),
                child: FlatButton(
                    color: Color.fromRGBO(0, 134, 81, 1),
                    child: Text('SIGN UP',
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
                        return;
                      }

                      Toast.show(context,
                          'Please enter the correct email address, password and confirm password',
                          icons: Icons.error_outline);
                    }),
              ),
            ],
          ),
        ),
        Positioned(
            top: ScreenUtil().setHeight(67),
            left: 0,
            child: IconButton(
              color: Colors.white,
              iconSize: 24,
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
      ],
    ));
  }
}
