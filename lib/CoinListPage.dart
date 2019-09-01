import 'package:flutter/material.dart';

import 'net/api.dart';

class CoinListPage extends StatefulWidget {
  @override
  State createState() {
    return new _CoinListPageState();
  }
}

class _CoinListPageState extends State<CoinListPage> {
  var mData = new List();

  void _refreshData() {
    API.getCryptoList(0, 300).then((result) {
      setState(() {
        print("--" + result.toString());
        mData = result;
      });
    });
  }

  void _getFavoriteList() {}

  bool _isFavorite(String symbol) {
    return false;
  }

  void _addFavorite(String symbol) {
    API.addFavorite(symbol).then((result){
      print(result);
    });
  }

  void _changeFavorite(String symbol) {
    if (_isFavorite(symbol)){
      _addFavorite(symbol);
    }else{
      _addFavorite(symbol);
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("代币列表"),
      ),
      body: new ListView.builder(
        itemCount: mData.length + 1,
        itemBuilder: (context, index) {
          var symbol;
          var cap;
          var favorite;
          var seq;

          Widget favWidget;
          if (0 == index) {
            symbol = "代币名称";
            cap = "代币市值(美元)";
            favorite = "收藏";
            seq = "排序";
            favWidget = new Text(
              favorite,
              textAlign: TextAlign.end,
            );
          } else {
            symbol = '${mData[index - 1].symbol}';
            cap = mData[index - 1].cap.toStringAsFixed(2);
            favorite = '';
            seq = index.toString();

            if (_isFavorite(symbol)) {
              favWidget = Icon(Icons.favorite);
            } else {
              favWidget = new Text("  ");
            }
          }

          return new GestureDetector(
            onTap: () {
              if ("代币名称" != symbol){
                _changeFavorite(symbol);
              }
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
                      cap,
                      textAlign: TextAlign.end,
                    ),
                    flex: 20,
                  ),
                  Expanded(
                    child: favWidget,
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
