import 'package:flutter/material.dart';

import 'net/api.dart';
import 'ws/WSManager.dart';
import 'net/entry/CryptoFavorite.dart';

class FavoriteListPage extends StatefulWidget {
  @override
  State createState() {
    return new _FavoriteListPageState();
  }
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  var mData = new List();
  var mDataMap = new Map();

  void _getFavoriteList() {
    API.getFavorite().then((result) {
      setState(() {
        mData = result;
      });
      _subWS();
    });
  }

  void _subWS(){
    for (CryptoFavorite item in mData){
      WSManager.instance.sub(item.symbol);
    }
  }

  @override
  void initState() {
    super.initState();
    _getFavoriteList();
    WSManager.instance.init();
    WSManager.instance.registerCallback(_wsDataReceive);
  }

  void _wsDataReceive(String data){
    List<String> tmp = data.split("-");
    if (tmp.length != 2){
      return;
    }

    String symbol;
    if ("btcusdt" == tmp[0]){
      symbol = "BTC";
    }else if (tmp[0].endsWith("btc")){
      symbol = tmp[0].substring(0, tmp[0].length - 3).toUpperCase();
    }else{
      return;
    }

    setState(() {
      mDataMap[symbol] = tmp[1];
    });
  }


  @override
  void dispose() {
    super.dispose();
    WSManager.instance.uninit();
    WSManager.instance.unRegisterCallback(_wsDataReceive);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("关注列表"),
      ),
      body: new ListView.builder(
        itemCount: mData.length + 1,
        itemBuilder: (context, index) {
          var symbol;
          var price;
          var favorite;
          var seq;

          Widget favWidget;
          if (0 == index) {
            symbol = "代币名称";
            price = "代币价格";
            favorite = "  ";
            seq = "排序";
            favWidget = new Text(
              favorite,
              textAlign: TextAlign.end,
            );
          } else {
            symbol = '${mData[index - 1].symbol}';
            price = "  ";
            if (mDataMap.containsKey(symbol)){
              price = mDataMap[symbol];
            }
            favorite = '';
            seq = index.toString();
          }

          return new GestureDetector(
            onTap: () {
              if ("代币名称" != symbol) {}
            },
            child: Container(
              margin: new EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: new Row(
                children: <Widget>[
                  Expanded(
                    child: new Text(seq),
                    flex: 8,
                  ),
                  Expanded(
                    child: new Text(symbol),
                    flex: 16,
                  ),
                  Expanded(
                    child: new Text(
                      price,
                      textAlign: TextAlign.end,
                    ),
                    flex: 20,
                  ),
                  Expanded(
                    child: new Text("  "),
                    flex: 8,
                  ),
                ],
              ),
            ),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
