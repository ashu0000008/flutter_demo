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

  void _refreshData(){
    API.getCryptoList(0, 200).then((result) {
      setState(() {
        print("--" + result.toString());
        mData = result;
      });
    });
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

          if (0 == index) {
            symbol = "代币名称";
            cap = "代币市值(美元)";
            favorite = "收藏";
            seq = "排序";
          } else {
            symbol = '${mData[index - 1].symbol}';
            cap = mData[index - 1].cap.toStringAsFixed(2);
            favorite = '';
            seq = index.toString();
          }

          return new Container(
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
                  child: new Text(
                    favorite,
                    textAlign: TextAlign.end,
                  ),
                  flex: 8,
                ),
              ],
            ),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}