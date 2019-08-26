import 'package:flutter/material.dart';

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
//          itemBuilder: (context, index){
//            return new ListTile(
//              title: new Text('${mData[index].symbol}'),
//
//            );
//          }
        itemBuilder: (context, index) {
          var symbol;
          var cap;
          var num;
          if (0 == index) {
            symbol = "平台名称";
            cap = "市值(美元)";
            num = "代币个数";
          } else {
            symbol = '${mData[index - 1].symbol}';
            cap = mData[index - 1].cap.toStringAsFixed(2);
            num = '${mData[index - 1].num}';
          }

          return new Container(
            margin: new EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: new Row(
              children: <Widget>[
                Expanded(
                  child: new Text(symbol),
                  flex: 20,
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
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
