import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(body: RadialBarCustomized()),
  ));
}

class RadialBarCustomized extends StatefulWidget {
  const RadialBarCustomized({super.key});

  @override
  State<RadialBarCustomized> createState() => _RadialBarCustomizedState();
}

class _RadialBarCustomizedState extends State<RadialBarCustomized> {
  TooltipBehavior? _tooltipBehavior;
  List<ChartSampleData>? _dataSources;
  List<ChartSampleData>? _chartData;
  List<CircularChartAnnotation>? _annotationSources;
  List<Color>? _colors;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      format: 'point.x : point.y%',
    );
    _dataSources = _buildAnnotationDataSource();
    _chartData = _buildChartData();
    _annotationSources = _buildAnnotationSources();

    _colors = const <Color>[
      Color.fromRGBO(69, 186, 161, 1.0),
      Color.fromRGBO(230, 135, 111, 1.0),
      Color.fromRGBO(145, 132, 202, 1.0),
      Color.fromRGBO(235, 96, 143, 1.0)
    ];

    super.initState();
  }

  List<ChartSampleData> _buildChartData() {
    return [
      ChartSampleData(
          x: 'Vehicle',
          y: 62.70,
          text: '100%',
          pointColor: const Color.fromRGBO(69, 186, 161, 1.0)),
      ChartSampleData(
          x: 'Education',
          y: 29.20,
          text: '100%',
          pointColor: const Color.fromRGBO(230, 135, 111, 1.0)),
      ChartSampleData(
          x: 'Home',
          y: 85.20,
          text: '100%',
          pointColor: const Color.fromRGBO(145, 132, 202, 1.0)),
      ChartSampleData(
          x: 'Personal',
          y: 45.70,
          text: '100%',
          pointColor: const Color.fromRGBO(235, 96, 143, 1.0)),
    ];
  }

  List<ChartSampleData> _buildAnnotationDataSource() {
    return [
      ChartSampleData(
        x: 'Vehicle',
        y: 62.70,
        text: '10%',
        pointColor: const Color.fromRGBO(69, 186, 161, 1.0),
      ),
      ChartSampleData(
        x: 'Education',
        y: 29.20,
        text: '10%',
        pointColor: const Color.fromRGBO(230, 135, 111, 1.0),
      ),
      ChartSampleData(
        x: 'Home',
        y: 85.20,
        text: '100%',
        pointColor: const Color.fromRGBO(145, 132, 202, 1.0),
      ),
      ChartSampleData(
        x: 'Personal',
        y: 45.70,
        text: '100%',
        pointColor: const Color.fromRGBO(235, 96, 143, 1.0),
      ),
    ];
  }

  List<CircularChartAnnotation> _buildAnnotationSources() {
    return [
      CircularChartAnnotation(
        widget: Icon(
          Icons.directions_car,
          size: 20,
          color: const Color.fromRGBO(69, 186, 161, 1.0),
        ),
      ),
      CircularChartAnnotation(
        widget: Icon(
          Icons.note,
          size: 20,
          color: const Color.fromRGBO(230, 135, 111, 1.0),
        ),
      ),
      CircularChartAnnotation(
        widget: Icon(
          Icons.home,
          size: 20,
          color: const Color.fromRGBO(145, 132, 202, 1.0),
        ),
      ),
      CircularChartAnnotation(
        widget: Icon(
          Icons.handshake_sharp,
          size: 20,
          color: const Color.fromRGBO(235, 96, 143, 1.0),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return _buildCustomizedRadialBarChart();
  }

  /// Returns the circular chart with radial bar customization.
  SfCircularChart _buildCustomizedRadialBarChart() {
    return SfCircularChart(
      legend: _buildLegend(),
      series: _buildRadialBarSeries(),
      tooltipBehavior: _tooltipBehavior,
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
          widget: Text('Percentage of loan closure',style: TextStyle(fontWeight: FontWeight.bold),),
        ),
      ],
    );
  }

  /// Builds the legend for the radial bar chart.
  Legend _buildLegend() {
    return Legend(
      isVisible: true,
      overflowMode: LegendItemOverflowMode.wrap,
      legendItemBuilder:
          (String name, dynamic series, dynamic point, int index) {
        return SizedBox(
          height: 60,
          width: 150,
          child: Row(children: <Widget>[
            SizedBox(
              height: 75,
              width: 65,
              child: SfCircularChart(
                annotations: <CircularChartAnnotation>[
                  _annotationSources![index],
                ],
                series: <RadialBarSeries<ChartSampleData, String>>[
                  RadialBarSeries<ChartSampleData, String>(
                    dataSource: <ChartSampleData>[_dataSources![index]],
                    xValueMapper: (ChartSampleData data, int index) => point.x,
                    yValueMapper: (ChartSampleData data, int index) => data.y,
                    pointColorMapper: (ChartSampleData data, int index) =>
                        data.pointColor,
                    pointRadiusMapper: (ChartSampleData data, int index) =>
                        data.text,
                    innerRadius: '70%',
                    animationDuration: 0,
                    maximumValue: 100,
                    radius: '100%',
                    cornerStyle: CornerStyle.bothCurve,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 72,
              child: Text(
                point.x,
                style: TextStyle(
                  color: _colors![index],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
        );
      },
    );
  }

  /// Returns the circular radial bar series.
  List<RadialBarSeries<ChartSampleData, String>> _buildRadialBarSeries() {
    return <RadialBarSeries<ChartSampleData, String>>[
      RadialBarSeries<ChartSampleData, String>(
        dataSource: _chartData,
        xValueMapper: (ChartSampleData data, int index) => data.x,
        yValueMapper: (ChartSampleData data, int index) => data.y,
        pointRadiusMapper: (ChartSampleData data, int index) => data.text,
        animationDuration: 0,
        maximumValue: 100,
        gap: '10%',
        radius: '90%',
        cornerStyle: CornerStyle.bothCurve,

        /// Color mapper for each bar in the radial bar series,
        /// obtained from the data source.
        pointColorMapper: (ChartSampleData data, int index) => data.pointColor,
        legendIconType: LegendIconType.circle,
      ),
    ];
  }

  @override
  void dispose() {
    _dataSources!.clear();
    _annotationSources!.clear();
    _chartData!.clear();
    super.dispose();
  }
}

///Chart sample data
class ChartSampleData {
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  final dynamic x;
  final num? y;
  final dynamic xValue;
  final num? yValue;
  final num? secondSeriesYValue;
  final num? thirdSeriesYValue;
  final Color? pointColor;
  final num? size;
  final String? text;
  final num? open;
  final num? close;
  final num? low;
  final num? high;
  final num? volume;
}
