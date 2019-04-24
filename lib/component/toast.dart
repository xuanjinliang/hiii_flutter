import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:hiii_flutter/component/config.dart';
import 'package:flutter/foundation.dart';

/// 创建一个toast弹窗
/// * context 为当前页面的context
/// * msg 提示的内容
/// bgColor 背景颜色
/// fontColor 字体颜色
/// fontSize 字体大小
/// icons 提示图标
/// duration 提示显示时间
/// anDuration 动画时间

class Toast {
  static final int BOTTOM = 1;
  static final int CENTER = 2;
  static final int TOP = 3;
  static ToastView toastView;

  static show(BuildContext context, String msg,
      {int gravity = 1,
      Color bgColor = const Color.fromRGBO(0, 0, 0, 0.65),
      Color fontColor = Colors.white,
      int fontSize = 32,
      IconData icons,
      int duration = 3000,
      int anDuration = 300}) {
    if (context == null || msg == null) {
      return;
    }

    if(toastView != null){
      toastView?.destroy();
      toastView = null;
    }

    OverlayState overlayState = Overlay.of(context);

    AnimationController controller = AnimationController(
        duration: Duration(milliseconds: anDuration), vsync: overlayState);

    OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => MessageTip(controller, msg,
            gravity: gravity,
            bgColor: bgColor,
            fontColor: fontColor,
            fontSize: fontSize,
            icons: icons));

    toastView =
        ToastView(overlayState, overlayEntry, controller, duration: duration);
    toastView._show();
  }
}

class ToastView {
  OverlayState overlayState;
  OverlayEntry overlayEntry;
  AnimationController controller;
  int duration;
  bool state = false;

  ToastView(this.overlayState, this.overlayEntry, this.controller,
      {@required this.duration})
      : assert(overlayState != null),
        assert(overlayEntry != null),
        assert(controller != null);

  _show() async {
    overlayState.insert(overlayEntry);
    this.controller.forward();
    await Future.delayed(Duration(milliseconds: this.duration));
    this.close();
  }

  close() async {
    this.controller.reverse();
    await Future.delayed(Duration(milliseconds: this.duration));
    this.destroy();
  }

  destroy(){
    if (state) {
      return;
    }
    state = true;
    overlayEntry?.remove();
  }
}

class MessageTip extends StatefulWidget {
  MessageTip(this.controller, this.msg,
      {Key key,
      @required this.gravity,
      @required this.bgColor,
      @required this.fontColor,
      @required this.fontSize,
      this.icons})
      : assert(controller != null),
        assert(msg != null),
        super(key: key);

  final AnimationController controller;
  final String msg;
  final int gravity;
  final Color bgColor;
  final Color fontColor;
  final int fontSize;
  final IconData icons;

  @override
  _MessageTipState createState() => _MessageTipState();
}

class _MessageTipState extends State<MessageTip> {
  Alignment direction;
  double top;
  double bottom;
  CurvedAnimation curve;

  int minWidth = 100;
  int maxWidth = 600;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    curve = CurvedAnimation(parent: widget.controller, curve: Curves.linear);

    switch (widget.gravity) {
      case 1:
        direction = Alignment.bottomCenter;
        bottom = ScreenUtil().setHeight(100);
        break;
      case 2:
        direction = Alignment.center;
        break;
      case 3:
        direction = Alignment.topCenter;
        top = ScreenUtil().setHeight(100);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FadeTransition(
      opacity: curve,
      child: Stack(
        alignment: direction,
        children: <Widget>[
          Positioned(
              top: top,
              bottom: bottom,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: widget.bgColor,
                  ),
                  constraints: BoxConstraints(
                      minWidth: ScreenUtil().setWidth(minWidth),
                      maxWidth: ScreenUtil().setWidth(maxWidth)),
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(10),
                      horizontal: ScreenUtil().setWidth(40)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textDirection: TextDirection.ltr,
                    verticalDirection: VerticalDirection.down,
                    children: <Widget>[
                      widget.icons != null
                          ? Container(
                              width: ScreenUtil().setWidth(widget.fontSize),
                              margin: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(10)),
                              child: Icon(widget.icons,
                                  color: widget.fontColor,
                                  size: ScreenUtil.getInstance()
                                      .setSp(widget.fontSize)),
                            )
                          : null,
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: ScreenUtil().setWidth(maxWidth - 40 * 2 - widget.fontSize - (widget.icons != null ? 10 : 0))),
                        child: Text(
                          widget.msg,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: widget.fontColor,
                              fontSize:
                              ScreenUtil.getInstance().setSp(widget.fontSize),
                              fontFamily: Config.FONTFAMILY,
                              decoration: TextDecoration.none),
                        ),
                      ),
                    ].where((element) => element != null).toList(),
                  )))
        ],
      ),
    );
  }
}
