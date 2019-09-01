import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'entry/CryptoFavorite.dart';
import 'entry/CryptoCoinInfo.dart';
import 'entry/CryptoPercent.dart';
import 'entry/CryptoPlatform.dart';
import 'entry/CryptoPlatformInfo.dart';
import 'urls.dart';

import 'package:uuid_enhanced/uuid.dart';

class API {
  static Dio mDio;

  static Future<Dio> getDio() async {

    if (null == mDio) {
      /// 获取手机的UUID
      String deviceId = Uuid.fromName('www.ashu.xyz', namespace: Uuid.NAMESPACE_URL).toString();
      mDio = new Dio();
      mDio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        //添加统一的请求头

        options.headers["deviceId"] = deviceId;
      }));
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
    Dio dio = await getDio();
    var response = await dio.get(ApiUrls.url_get_crypto_percent + symbol);
    String _content = response.data.toString();
    return _content;
  }

  static Future<List<CryptoPercent>> getCryptoPercentHistory(
      String symbol) async {
    Dio dio = await getDio();
    var url =
        ApiUrls.url_get_crypto_percent_history.replaceAll(":symbol", symbol);
    var response = await dio.get(url);
    String _content = response.data.toString();

    List responseJson = json.decode(_content);
    List<CryptoPercent> result =
        responseJson.map((m) => new CryptoPercent.fromJson(m)).toList();
    return result;
  }

  static Future<List<CryptoPlatform>> getPlatformSummary() async {
    Dio dio = await getDio();
    var response = await dio.get(ApiUrls.url_get_platforms_summary);
    String _content = response.data.toString();

    List responseJson = json.decode(_content);
    List<CryptoPlatform> result =
        responseJson.map((m) => new CryptoPlatform.fromJson(m)).toList();
    return result;
  }

  static Future<List<CryptoPlatformInfo>> getPlatformInfo(
      String platform) async {
    Dio dio = await getDio();
    var response = await dio.get(ApiUrls.url_get_platform_info + platform);
    String _content = response.data.toString();

    List responseJson = json.decode(_content);
    List<CryptoPlatformInfo> result =
        responseJson.map((m) => new CryptoPlatformInfo.fromJson(m)).toList();
    return result;
  }

  static Future<List<CryptoCoin>> getCryptoList(int page, int size) async {
    Dio dio = await getDio();
    var response = await dio.get(ApiUrls.url_get_crypto_list, queryParameters: {"page":page, "size":size});
    String _content = response.data.toString();

    List responseJson = json.decode(_content);
    List<CryptoCoin> result =
    responseJson.map((m) => new CryptoCoin.fromJson(m)).toList();
    return result;
  }

  static Future<bool> addFavorite(String symbol) async{
    Dio dio = await getDio();
    var response = await dio.post(ApiUrls.url_post_favorite, data: FormData.from({"symbol":symbol}));
    print(response);
    return true;
  }

  static Future<bool> removeFavorite(String symbol) async{
    Dio dio = await getDio();
    var response = await dio.delete(ApiUrls.url_remove_favorite, data: FormData.from({"symbol":symbol}));
    print(response);
    return true;
  }

  static Future<List<CryptoFavorite>> getFavorite() async{
    Dio dio = await getDio();
    var response = await dio.get(ApiUrls.url_get_favorite);
    String _content = response.data.toString();

    List responseJson = json.decode(_content);
    List<CryptoFavorite> result =
    responseJson.map((m) => new CryptoFavorite.fromJson(m)).toList();
    return result;
  }
}
