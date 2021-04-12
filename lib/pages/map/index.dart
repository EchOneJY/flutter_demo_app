import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text('地图'),
          ),
          body: Center(child: Text('地图'))),
    );
  }
}
