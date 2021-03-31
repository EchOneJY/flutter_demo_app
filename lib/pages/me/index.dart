import 'package:flutter/material.dart';

class MePage extends StatelessWidget {
  const MePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('我的'),
        ),
        body: RaisedButton(
          child: Text('to form'),
          onPressed: () => {
            Navigator.of(context).pushNamed('/form', arguments: {'id': '123'})
          },
        ),
      ),
    );
  }
}
