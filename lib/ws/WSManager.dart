import 'dart:async';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WSManager {
  // 工厂模式
  factory WSManager() => _getInstance();

  static WSManager get instance => _getInstance();
  static WSManager _instance;

  WSManager._internal() {
    // 初始化
    _init();
  }

  static WSManager _getInstance() {
    if (_instance == null) {
      _instance = new WSManager._internal();
    }
    return _instance;
  }

  WebSocketChannel _channel;

  void _init() {
    _channel = new IOWebSocketChannel.connect('ws://ashu.xyz:9000/ws');
    _loopTest();
    _channel.stream.listen((data) {
      print(data.toString());
    });
  }

  void _uninit() {
    _channel.sink.close();
  }

  void _loopTest() {
    var loop = 1;
    Timer.periodic(Duration(seconds: 5), (timer) {
      _channel.sink.add("ws count:" + loop.toString());
      loop++;
    });
  }
}
