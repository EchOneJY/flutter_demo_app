import 'package:flutter/material.dart';
import 'package:mk_flutter_app/models/queue_info.dart';

class QueueDetail extends StatelessWidget {
  final QueueInfoModel queueInfo;

  QueueDetail(this.queueInfo);

  _formatQueueStatus(status) {
    switch (status) {
      case 0:
        return '待排队';
        break;
      case 1:
        return '排队中';
      case 2:
        return '进厂中';
      case 3:
        return '已进厂';
      case 4:
        return '已取消';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 30, left: 35, right: 20),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _queueNumber(), //排队号码
              _queueInfo() //排队详情
            ],
          ),
        ]));
  }

  Widget _queueNumber() {
    return Column(children: [
      Text(
        '排队号码',
        style: TextStyle(color: Color(0xffA1A5B2), fontSize: 12),
      ),
      SizedBox(height: 12),
      Text(queueInfo.allocateNum.toString(),
          style: TextStyle(fontSize: 36, color: Color(0xff414B67)))
    ]);
  }

  Widget _queueInfo() {
    return Column(
      children: [
        _queueInfoItem('前面等待', queueInfo.waitingNumber.toString(), null),
        SizedBox(height: 8),
        _queueInfoItem('车牌号码', queueInfo.vno, null),
        SizedBox(height: 8),
        _queueInfoItem('排队状态', _formatQueueStatus(queueInfo.queueStatus), 1),
      ],
    );
  }

  Widget _queueInfoItem(String label, String value, int state) {
    Widget _valueText;
    if (state != null) {
      _valueText = Container(
          padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: state == 0 ? Color(0xff00A7F9) : Color(0xffFF7100)),
          child: Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ));
    } else {
      _valueText = Text(
        value,
        textAlign: TextAlign.right,
        style: TextStyle(color: Color(0xff414B67), fontSize: 12),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(color: Color(0xffA1A5B2), fontSize: 12),
        ),
        Container(
            constraints: BoxConstraints(minWidth: 70),
            margin: EdgeInsets.only(left: 6),
            alignment: Alignment.centerRight,
            child: _valueText)
      ],
    );
  }
}
