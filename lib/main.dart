import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(body: OverfilledRadialBar()),
  ));
}

class OverfilledRadialBar extends StatefulWidget {
  const OverfilledRadialBar({super.key});

  @override
  OverfilledRadialBarState createState() => OverfilledRadialBarState();
}

class OverfilledRadialBarState extends State<OverfilledRadialBar> {
  TooltipBehavior? _tooltipBehavior;
  late List<ChartData> _chartData;

  @override
  void initState() {
    _chartData = [
      ChartData('Low \n3.5k/6k', 3500, Color.fromRGBO(235, 97, 143, 1), 'Low'),
      ChartData('Average \n7.2k/6k', 7000, Color.fromRGBO(145, 132, 202, 1),
          'Average'),
      ChartData(
          'High \n10.5k/6k', 10500, Color.fromRGBO(69, 187, 161, 1), 'High'),
    ];
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildRadialBarChart();
  }

  SfCircularChart _buildRadialBarChart() {
    return SfCircularChart(
        legend: Legend(
          isVisible: true,
          iconHeight: 20,
          iconWidth: 20,
          overflowMode: LegendItemOverflowMode.wrap,
        ),
        annotations: <CircularChartAnnotation>[
          _buildAnnotation(),
        ],
        series: <RadialBarSeries<ChartData, String>>[
          RadialBarSeries<ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (ChartData data, int index) => data.x,
            yValueMapper: (ChartData data, int index) => data.y,
            pointColorMapper: (ChartData data, int index) => data.color,
            dataLabelMapper: (ChartData data, int index) => data.text,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            maximumValue: 6000,
            radius: '70%',
            gap: '2%',
            cornerStyle: CornerStyle.bothCurve,
          ),
        ],
        tooltipBehavior: _tooltipBehavior,
        onTooltipRender: (TooltipArgs args) {
          final NumberFormat numberFormat = NumberFormat.compactCurrency(
            decimalDigits: 2,
            symbol: '',
          );
          args.text =
              '${_chartData[args.pointIndex as int].text} : ${numberFormat.format(_chartData[args.pointIndex as int].y)}';
        });
  }

  CircularChartAnnotation _buildAnnotation() {
    return CircularChartAnnotation(
      height: '35%',
      width: '65%',
      widget: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text('Goal -',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          Text('6k steps/day',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color, this.text);
  final String x;
  final num y;
  final Color color;
  final String text;
}
