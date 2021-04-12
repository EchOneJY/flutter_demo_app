import 'dart:async';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class HttpRequest {
  final baseUrl;

  HttpRequest(this.baseUrl);

  Future<dynamic> get(String uri, {Map<String, String> headers}) async {
    try {
      http.Response response = await http.get(baseUrl + uri, headers: headers);
      final statusCode = response.statusCode;
      final body = response.body;
      if (statusCode == 200) {
        final res = jsonDecode(body);
        if (res['status'] == 0) {
          return res['result'];
        } else {
          EasyLoading.showToast(res['message'] ??= '接口请求错误');
        }
      } else {
        EasyLoading.instance..displayDuration = const Duration(seconds: 10);
        EasyLoading.showToast('接口请求错误,错误码：$statusCode');
      }
    } on Exception catch (e) {
      EasyLoading.instance..displayDuration = const Duration(seconds: 10);
      EasyLoading.showToast('接口请求错误:$e');
    }
  }
}
