
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../net/urls.dart';

class WSManager {
  // 工厂模式
  factory WSManager() => _getInstance();

  static WSManager get instance => _getInstance();
  static WSManager _instance;

  WSManager._internal();

  static WSManager _getInstance() {
    if (_instance == null) {
      _instance = new WSManager._internal();
    }
    return _instance;
  }

  WebSocketChannel _channel;

  void _init() {
    _channel = new IOWebSocketChannel.connect(ApiUrls.ws_url);
    _channel.stream.listen((data) {
      _doCallbacks(data.toString());
    });
  }

  void _uninit() {
    _channel.sink.close();
  }

//  void _loopTest() {
//    var loop = 1;
//    Timer.periodic(Duration(seconds: 5), (timer) {
//      _channel.sink.add("ws count:" + loop.toString());
//      loop++;
//    });
//  }

  void init() {
    _init();
  }

  void uninit() {
    _uninit();
  }

  void sub(String symbol) {
    print("add:" + symbol.toLowerCase());
    _channel.sink.add("add:" + symbol.toLowerCase());
  }

  Set<Function> _callbacks = new Set();
  void registerCallback(Function func){
    _callbacks.add(func);
  }
  void unRegisterCallback(Function func){
    _callbacks.remove(func);
  }

  void _doCallbacks(String data){
    for (Function func in _callbacks){
      func(data);
    }
  }
}
