import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/no_info.png'),
              width: 165,
              height: 110,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "无运输任务",
              style: TextStyle(color: Color(0xff414B67), fontSize: 16),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              "暂未找到您的运输任务哦",
              style: TextStyle(color: Color(0xffA1A5B2), fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
