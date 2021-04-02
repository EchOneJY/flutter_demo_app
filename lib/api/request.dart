import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpRequest {
  final baseUrl;

  HttpRequest(this.baseUrl);

  Future<dynamic> get(String uri, {Map<String, String> headers}) async {
    try {
      http.Response response = await http.get(baseUrl + uri, headers: headers);
      final statusCode = response.statusCode;
      final body = response.body;
      // print('[uri=$uri][statusCode=$statusCode][response=$body]');
      if (statusCode == 200) {
        return jsonDecode(body);
      } else {
        throw Exception('请求错误');
      }
    } on Exception catch (e) {
      print('[uri=$uri]exception e=${e.toString()}');
      return '';
    }
  }
}
