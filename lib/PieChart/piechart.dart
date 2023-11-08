import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PChart extends StatefulWidget {
  const PChart({super.key});

  @override
  State<PChart> createState() => _PChartState();
}

class _PChartState extends State<PChart> {
  @override
  Widget build(BuildContext context) {
    final List<PieChartSectionData> pieCharSections = [
      PieChartSectionData(
        value: 35,
        color: Colors.blue,
        title: 'Food',
        radius : 100,
      ),
      PieChartSectionData(
        value: 20,
        color: Colors.green,
        title: 'Health',
        radius : 100,
      ),
      PieChartSectionData(
        value: 45,
        color: Colors.red,
        title: 'Stationary',
        radius : 100,
      ),
      PieChartSectionData(
        value: 12,
        color: Colors.teal,
        title: "Travel",
        radius : 100,
      )
    ];
    final PieChartData pieChartData = PieChartData(
      sections: pieCharSections,
      sectionsSpace: 0,
      centerSpaceRadius: 60,
    );

    return PieChart(pieChartData);
  }
}
