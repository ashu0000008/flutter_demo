import 'package:flutter/material.dart';

import 'PercentChartPage.dart';
import 'PlatformsPage.dart';
import 'net/api.dart';
import 'ws/WSManager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Demo'),
      routes: {
        '/home': (context) => MyApp(),
        '/platforms/summary': (context) => PlatformsPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = "0";

  void _refreshPercentBTC() {
    API.getCryptoPercent("btc").then((percent) {
      setState(() {
        print("--" + percent);
        var percentDouble = double.parse(percent) * 100;
        _counter = percentDouble.toStringAsFixed(2);
      });
    });
  }

  void _gotoPlatformsPage() {
    Navigator.pushNamed(context, '/platforms/summary');
  }

  void _gotoPercentPageBTC() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
      return new PercentChartPage("BTC");
    }));
  }

  void _wstest(){
    WSManager.instance;
  }

  @override
  void initState() {
    super.initState();
    _refreshPercentBTC();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new Text('大饼占比 ' + '$_counter' + '%'),
            onTap: _gotoPercentPageBTC,
          ),
          new ListTile(
            title: new Text('币种排序'),
            onTap: _wstest,
          ),
          new ListTile(
            title: new Text('平台排序'),
            onTap: _gotoPlatformsPage,
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
