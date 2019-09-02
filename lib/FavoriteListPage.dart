import 'package:flutter/material.dart';

import 'net/api.dart';

class FavoriteListPage extends StatefulWidget {
  @override
  State createState() {
    return new _FavoriteListPageState();
  }
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  var mData = new List();

  void _getFavoriteList() {
    API.getFavorite().then((result) {
      setState(() {
        mData = result;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getFavoriteList();
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
