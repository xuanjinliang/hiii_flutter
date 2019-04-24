import 'package:flutter/material.dart';
import 'package:hiii_flutter/home/home.dart';
import 'package:hiii_flutter/booking/booking.dart';
import 'package:hiii_flutter/user/user.dart';
import 'package:hiii_flutter/home/shateDataWidget.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  double bottom = 0;

  final List<Widget> _children = [Home(), Booking(), User()];

  Widget child(BuildContext context) {
    Widget widget = _children[_currentIndex];

    if (_currentIndex == 0) {
      return ShareDataWidget(
        bottom: bottom,
        child: widget,
      );
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      bottom = MediaQuery.of(context).viewInsets.bottom;
    });

    // TODO: implement build
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: child(context),
        bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.business), title: Text('HOTELS')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_books), title: Text('BOOKING')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), title: Text('ME')),
            ],
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            }));
  }
}
