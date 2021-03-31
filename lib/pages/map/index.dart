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
          body: Column(
            children: [
              RaisedButton(
                child: Text('to tabs'),
                onPressed: () => {Navigator.of(context).pushNamed('/')},
              ),
            ],
          )),
    );
  }
}
