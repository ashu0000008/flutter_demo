import 'package:flutter/material.dart';

import 'PlatformPage.dart';
import 'net/api.dart';

class PlatformsPage extends StatefulWidget {
  @override
  _PlatformsPageState createState() => _PlatformsPageState();
}

class _PlatformsPageState extends State<PlatformsPage> {
  var mData = new List();

  void _refreshData() {
    API.getPlatformSummary().then((result) {
      setState(() {
        print("--" + result.toString());
        mData = result;
      });
    });
  }

  void _goPlatformPage(int index) {
    if (0 == index) {
      return;
    }

    Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
      var platform = mData[index - 1].symbol;
      return new PlatformPage(platform);
    }));
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
        title: Text("平台排行榜"),
      ),
      body: new ListView.builder(
        itemCount: mData.length + 1,
        itemBuilder: (context, index) {
          var symbol;
          var cap;
          var num;
          var seq;

          if (0 == index) {
            symbol = "平台名称";
            cap = "代币总市值(美元)";
            num = "代币个数";
            seq = "排序";
          } else {
            symbol = '${mData[index - 1].symbol}';
            cap = mData[index - 1].cap.toStringAsFixed(2);
            num = '${mData[index - 1].num}';
            seq = index.toString();
          }

          return new Container(
            margin: new EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: new GestureDetector(
              onTap: () {
                _goPlatformPage(index);
              },
              child: new Row(
                children: <Widget>[
                  Expanded(
                    child: new Text(seq),
                    flex: 6,
                  ),
                  Expanded(
                    child: new Text(symbol),
                    flex: 18,
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
                      num,
                      textAlign: TextAlign.end,
                    ),
                    flex: 12,
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
