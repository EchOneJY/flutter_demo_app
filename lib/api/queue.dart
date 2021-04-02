import 'dart:async';

import 'package:mk_flutter_app/api/request.dart';

const BASE_URL = 'http://localhost:5758';

final _request = HttpRequest(BASE_URL);

const String QUEUE_INFO = '/app/queue/queryQueueInfo';

Future queryQueueInfo() async {
  final result = await _request.get(QUEUE_INFO);
  return result;
}
