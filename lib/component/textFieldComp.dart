import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

/// 登录 注册 用TextFieldComp 输入框
/// * title 输入框标题
/// * controller 输入框控制器
/// hint 提示内容
/// obscureText 隐藏字符
/// inputType 显示输入键盘特定字符
/// validator 验证的方法

class TextFieldComp extends StatefulWidget {
  const TextFieldComp(this.title, this.controller,
      {Key key,
        this.hint,
        this.obscureText = false,
        this.inputType = TextInputType.text,
        this.validator})
      : assert(title != null),
        assert(controller != null),
        super(key: key);

  final String title;
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final TextInputType inputType;
  final Function validator;

  @override
  _TextFieldCompState createState() => _TextFieldCompState();
}

class _TextFieldCompState extends State<TextFieldComp> {
  Color fontColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: ScreenUtil().setWidth(600),
      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(34)),
      child: Theme(
        data: ThemeData(
            primaryColor: this.fontColor,
            hintColor: this.fontColor,
            inputDecorationTheme: InputDecorationTheme(
                contentPadding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setWidth(37),
                    horizontal: ScreenUtil().setWidth(60)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().setWidth(50))),
                    borderSide: BorderSide(width: ScreenUtil().setWidth(2))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().setWidth(50))),
                    borderSide: BorderSide(
                        color: this.fontColor,
                        width: ScreenUtil().setWidth(2),
                        style: BorderStyle.solid)),
                labelStyle: TextStyle(
                    color: this.fontColor,
                    fontSize: ScreenUtil.getInstance().setSp(36)),
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: ScreenUtil.getInstance().setSp(24)),
                errorStyle: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(0), height: 0))),
        child: TextFormField(
          keyboardType: widget.inputType,
          obscureText: widget.obscureText,
          controller: widget.controller,
          decoration:
          InputDecoration(labelText: widget.title, hintText: widget.hint),
          cursorColor: this.fontColor,
          cursorWidth: ScreenUtil().setWidth(1),
          style: TextStyle(
              color: this.fontColor,
              fontSize: ScreenUtil.getInstance().setSp(26)),
          validator: widget.validator is Function ? widget.validator : null,
        ),
      ),
    );
  }
}