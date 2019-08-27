import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'entry/CryptoPlatform.dart';
import 'entry/CryptoPlatformInfo.dart';
import 'urls.dart';

class API {
  static Dio mDio;

  static Dio getDio() {
    if (null == mDio) {
      mDio = new Dio();
      (mDio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          print(host + ":" + String.fromCharCode(port));
          return true;
        };
      };
    }
    return mDio;
  }

  static Future<String> getCryptoPercent(String symbol) async {
    Dio dio = getDio();
    var response = await dio.get(ApiUrls.url_get_crypto_percent + symbol);
    String _content = response.data.toString();
    return _content;
  }

  static Future<List<CryptoPlatform>> getPlatformSummary() async {
    Dio dio = getDio();
    var response = await dio.get(ApiUrls.url_get_platforms_summary);
    String _content = response.data.toString();

    List responseJson = json.decode(_content);
    List<CryptoPlatform> platforms =
        responseJson.map((m) => new CryptoPlatform.fromJson(m)).toList();
    return platforms;
  }

  static Future<List<CryptoPlatformInfo>> getPlatformInfo(String platform) async {
    Dio dio = getDio();
    var response = await dio.get(ApiUrls.url_get_platform_info+platform);
    String _content = response.data.toString();

    List responseJson = json.decode(_content);
    List<CryptoPlatformInfo> tokens =
    responseJson.map((m) => new CryptoPlatformInfo.fromJson(m)).toList();
    return tokens;
  }
}
