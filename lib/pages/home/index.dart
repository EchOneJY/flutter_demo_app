import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> lineNames = ['北京市海淀区第三中路', '北京市海淀区中关村软件园'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            tileMode: TileMode.repeated,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff4BBE87), Color(0xff43C178)]),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('排队管理'),
            centerTitle: true,
          ),
          body: Padding(
            padding:
                EdgeInsets.only(top: 15, right: 22.5, bottom: 15, left: 22.5),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(children: [_queueLine()])),
          )),
    );
  }

  _queueLine() {
    return Container(
        width: double.infinity,
        height: 150,
        padding: EdgeInsets.only(top: 25, bottom: 15, left: 25),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: Offset(0, 8),
              color: Color(0xff26585e7e),
              blurRadius: 8,
              spreadRadius: 0)
        ], color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xffFFECD8),
                      Colors.white,
                    ])),
            child: Row(
              children: [
                Container(
                  width: 25,
                  height: 25,
                  child: Icon(
                    Icons.priority_high,
                    color: Colors.white,
                    size: 12,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xffFF372F),
                            Color.fromARGB(1, 255, 58, 49),
                          ])),
                ),
                SizedBox(width: 8),
                Text(
                  '请在附近安全区域停车，等候进厂',
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
          // SizedBox(height: 20),
          Column(
            children: lineNames.map((name) => _lineItem(context, name)),
          )
        ]));
  }

  Widget _lineItem(BuildContext context, String name) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 7,
          height: 7,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              color: Color(0xff00ABFF), borderRadius: BorderRadius.circular(7)),
        ),
        Text(name),
        SizedBox(width: 10),
        Image(
          image: AssetImage('images/icon_route_line.png'),
          width: 16,
          height: 16,
        )
      ],
    );
  }
}
