import 'package:flutter/material.dart';
import 'package:mk_flutter_app/api/queue.dart';
import 'package:mk_flutter_app/models/queue_info.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  QueueInfoModel _mapQueueInfo = new QueueInfoModel();
  int _queueStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _queryQueueInfo();
  }

  _queryQueueInfo() async {
    final res = await queryQueueInfo();
    print(res['status']);
    if (res['status'] == 0) {
      setState(() {
        print(_mapQueueInfo.runtimeType.toString());
        _mapQueueInfo = QueueInfoModel.fromJson(res['result']);
        _queueStatus = _mapQueueInfo.queueStatus;
      });
    }
  }

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

  _onPress() {}

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
                child: Column(children: [
                  _queueLine(), //排队路线
                  _queueDetail(), //排队详情
                  Container(
                      width: 200,
                      height: 50,
                      margin: EdgeInsets.only(top: 50),
                      child: RaisedButton(
                        onPressed: _onPress,
                        child: Text('取消排队'),
                        textColor: Colors.white,
                        color: Color(0xffFF7100),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        elevation: 2,
                      ))
                ])),
          )),
    );
  }

  Widget _queueLine() {
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
          SizedBox(height: 20),
          Column(children: [
            _lineItem('北京市海淀区第三中路', 0),
            SizedBox(height: 12),
            _lineItem('北京市海淀区中关村软件园', 1),
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

  Widget _queueDetail() {
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
      Text(_mapQueueInfo.allocateNum.toString(),
          style: TextStyle(fontSize: 36, color: Color(0xff414B67)))
    ]);
  }

  Widget _queueInfo() {
    return Column(
      children: [
        _queueInfoItem('前面等待', _mapQueueInfo.waitingNumber.toString(), null),
        SizedBox(height: 8),
        _queueInfoItem('车牌号码', _mapQueueInfo.vno, null),
        SizedBox(height: 8),
        _queueInfoItem('排队状态', _formatQueueStatus(_queueStatus),
            1), //_formatQueueStatus(_mapQueueInfo.queueStatus)
      ],
    );
  }

  Widget _queueInfoItem(String label, String value, int state) {
    Widget valueText;
    if (state != null) {
      valueText = Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: state == 0 ? Color(0xff00A7F9) : Color(0xffFF7100)),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ));
    } else {
      valueText = Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xff414B67), fontSize: 12),
      );
    }
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(color: Color(0xffA1A5B2), fontSize: 12),
        ),
        Container(
            width: 70, margin: EdgeInsets.only(left: 20), child: valueText)
      ],
    );
  }
}
