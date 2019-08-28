import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'net/entry/CryptoPercent.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  static List<CryptoPercent> mData;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData(List<CryptoPercent> data) {
    mData = data;
    return new SimpleTimeSeriesChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.LineRendererConfig(includeArea: true, stacked: true, areaOpacity: 0.5),
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    var data = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
    ];
    if (null != mData) {
      for (CryptoPercent percent in mData) {
        List<String> tmp = percent.date.split("-");
        if (tmp.length != 3) {
          continue;
        }
        int percentShown = (percent.percent * 100).toInt();
        data.add(new TimeSeriesSales(
            new DateTime(
                int.parse(tmp[0]), int.parse(tmp[1]), int.parse(tmp[2])),
            percentShown));
      }
      data.removeAt(0);
    } else {
      data = [
        new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
        new TimeSeriesSales(new DateTime(2017, 9, 26), 25),
        new TimeSeriesSales(new DateTime(2017, 10, 3), 100),
        new TimeSeriesSales(new DateTime(2017, 10, 10), 75),
      ];
    }

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
        measureUpperBoundFn: (_, num) => 100,
        measureLowerBoundFn: (_, num) => 0,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
