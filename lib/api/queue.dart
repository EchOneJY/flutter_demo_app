import 'dart:async';

import 'package:mk_flutter_app/api/request.dart';

// const BASE_URL = 'http://localhost:5758';
const BASE_URL = 'http://192.168.3.179:5758';

final _request = HttpRequest(BASE_URL);

const String LOGIN_INFO = '/app/queue/queryLogisticsInfo';
const String QR_CODE = '/app/queue/twdTranCode';
const String QUEUE_INFO = '/app/queue/queryQueueInfo';
const String CANCEL_QUEUE = '/app/queue/cancelQueue';

Future queryLoginInfo() async {
  final result = await _request.get(LOGIN_INFO);
  return result;
}

Future queryQrCode(id) async {
  final result = await _request.get(QR_CODE + '?id=$id');
  return result;
}

Future queryQueueInfo() async {
  final result = await _request.get(QUEUE_INFO);
  return result;
}

Future cancelQueue() async {
  final result = await _request.get(CANCEL_QUEUE);
  return result;
}
