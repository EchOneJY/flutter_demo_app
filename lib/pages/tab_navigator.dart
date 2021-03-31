import 'package:flutter/material.dart';
import 'package:mk_flutter_app/pages/home/index.dart';
import 'package:mk_flutter_app/pages/map/index.dart';
import 'package:mk_flutter_app/pages/me/index.dart';

class TabNavigator extends StatefulWidget {
  TabNavigator({Key key}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final List<Widget> _children = [HomePage(), MapPage(), MePage()];

  int _currntIndex = 0;

  void onTapAction(int index) {
    setState(() {
      _currntIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: _children[_currntIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xff00C46F),
          unselectedItemColor: Color(0xffA8ACB8),
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          currentIndex: _currntIndex,
          onTap: onTapAction,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
            BottomNavigationBarItem(icon: Icon(Icons.location_on), label: '地图'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
          ],
        ),
      ),
    );
  }
}
