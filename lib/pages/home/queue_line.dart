import 'package:flutter/material.dart';
import 'package:mk_flutter_app/models/queue_info.dart';

class QueueLine extends StatelessWidget {
  final QueueInfoModel queueInfo;

  QueueLine(this.queueInfo);

  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 25,
                  height: 25,
                  child: Icon(
                    Icons.priority_high,
                    color: Colors.white,
                    size: 16,
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
          SizedBox(height: 20),
          Column(children: [
            _lineItem(queueInfo.loadGoodsAddr, 0),
            SizedBox(height: 12),
            _lineItem(queueInfo.unloadGoodsAddr, 1),
          ])
        ]));
  }

  Widget _lineItem(String name, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 7,
          height: 7,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              color: Color(index == 0 ? 0xff00ABFF : 0xffFF7100),
              borderRadius: BorderRadius.circular(7)),
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
