import 'package:flutter/cupertino.dart';

class QueueInfoModel {
  final int queueStatus;
  final int allocateNum;
  final int waitingNumber;
  final String vno;
  final String loadGoodsAddr;
  final String unloadGoodsAddr;

  QueueInfoModel(
      {this.queueStatus = 0,
      this.allocateNum = 0,
      this.waitingNumber = 0,
      this.vno = '',
      this.loadGoodsAddr = '',
      this.unloadGoodsAddr = ''});

  QueueInfoModel.fromJson(Map<String, dynamic> map)
      : queueStatus = map['queueStatus'],
        allocateNum = map['allocateNum'],
        waitingNumber = map['waitingNumber'],
        vno = map['vno'],
        loadGoodsAddr = map['loadGoodsAddr'],
        unloadGoodsAddr = map['unloadGoodsAddr'];
}
