import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mk_flutter_app/api/queue.dart';
import 'package:mk_flutter_app/models/queue_info.dart';
import 'package:mk_flutter_app/pages/home/empty_page.dart';
import 'package:mk_flutter_app/pages/home/queue_detail.dart';
import 'package:mk_flutter_app/pages/home/queue_line.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  QueueInfoModel _queueInfo = new QueueInfoModel();

  //二维码
  String _qrCodeId = '';

  bool _hasInfo = false;

  @override
  void initState() {
    //获取排队信息
    _queryQueueInfo();

    super.initState();
  }

  _queryQueueInfo() {
    queryLoginInfo().then((res) => res).then((id) {
      // 获取二维码
      queryQrCode(id).then((res) {
        final result = jsonDecode(res);
        setState(() {
          _qrCodeId = result['tranId'];
        });
      });

      // 请求排队信息
      queryQueueInfo().then((res) {
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _hasInfo = true;
            _queueInfo = QueueInfoModel.fromJson(res);
          });
        });
      });
    });
  }

  //点击取消按钮
  _onCancelPress() async {
    EasyLoading.show(status: '取消排队中...');
    final res = await cancelQueue();
    if (res['status'] == 0) {
      // 重新请求排队信息
      _queryQueueInfo();
      Timer(Duration(seconds: 1), () {
        EasyLoading.dismiss();
      });
    } else {
      EasyLoading.dismiss();
    }
  }

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
          backgroundColor: _hasInfo ? Colors.transparent : Colors.white,
          appBar: AppBar(
            backgroundColor: _hasInfo ? Colors.transparent : Colors.white,
            elevation: 0,
            title: Text(
              '排队管理',
              style: TextStyle(
                  color:
                      _hasInfo ? Colors.white : Color.fromRGBO(65, 75, 103, 1)),
            ),
            centerTitle: true,
          ),
          body: _hasInfo ? _queuenPage() : EmptyPage()),
    );
  }

  Widget _queuenPage() {
    return Padding(
      padding: EdgeInsets.only(top: 15, right: 22.5, bottom: 15, left: 22.5),
      child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Column(children: [
            QueueLine(_queueInfo), //排队路线
            QueueDetail(_queueInfo), //排队详情
            _qrCode(), // 二维码
            _cancelButton() // 取消按钮
          ])),
    );
  }

  Widget _qrCode() {
    return Column(children: [
      SizedBox(height: 10),
      QrImage(
        data: _qrCodeId,
        version: QrVersions.auto,
        size: 160.0,
      )
    ]);
  }

  Widget _cancelButton() {
    if (_queueInfo.queueStatus == 1) {
      return Container(
          width: 200,
          height: 50,
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(0xffFF7100),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 8),
                    color: Color.fromRGBO(255, 113, 0, 0.3),
                    blurRadius: 11,
                    spreadRadius: 0)
              ]),
          child: ElevatedButton(
            onPressed: _onCancelPress,
            child: Text('取消排队'),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                textStyle: MaterialStateProperty.all(
                    TextStyle(fontSize: 18, letterSpacing: 1)),
                backgroundColor: MaterialStateProperty.all(Color(0xffFF7100)),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))))),
          ));
    } else {
      return Container(
        width: 0,
        height: 0,
      );
    }
  }
}
