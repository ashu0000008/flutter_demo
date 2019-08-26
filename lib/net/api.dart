import 'package:dio/dio.dart';
import 'dart:io';
import 'urls.dart';

class API {
  static Future<String> get_crypto_percent(String symbol) async {
    Dio dio = new Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        print(host+":"+String.fromCharCode(port));
        return true;
      };
    };
    var response = await dio.get(ApiUrls.url_get_crypto_percent + symbol);
    String _content = response.data.toString();
    return _content;
  }
}
