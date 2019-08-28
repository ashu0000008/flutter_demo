import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ChartView.dart';
import 'net/api.dart';
import 'net/entry/CryptoPercent.dart';

class PercentChartPage extends StatefulWidget {
  final String symbol;

  @override
  _PercentChartPageState createState() => _PercentChartPageState(symbol);

  PercentChartPage(this.symbol);
}

class _PercentChartPageState extends State<PercentChartPage> {
  var symbol;
  List<CryptoPercent> mData = new List();

  _PercentChartPageState(this.symbol);

  @override
  void initState() {
    super.initState();
    _refreshData();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  void _refreshData() {
    API.getCryptoPercentHistory(symbol).then((result) {
      setState(() {
        print("--" + result.toString());
        mData = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleTimeSeriesChart.withSampleData(mData);
  }
}
