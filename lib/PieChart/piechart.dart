import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PChart extends StatefulWidget {
  const PChart({Key? key}) : super(key: key);

  @override
  _PChartState createState() => _PChartState();
}

class _PChartState extends State<PChart> {
  List<PieChartSectionData> pieCharSections = [
    PieChartSectionData(
      value: 35,
      color: Colors.blue,
      title: 'Food',
      radius: 100,
    ),
    PieChartSectionData(
      value: 20,
      color: Colors.green,
      title: 'Hygiene',
      radius: 100,
    ),
    PieChartSectionData(
      value: 45,
      color: Colors.red,
      title: 'Home',
      radius: 100,
    ),
    PieChartSectionData(
      value: 45,
      color: Colors.pink,
      title: 'Stationary',
      radius: 100,
    ),
    PieChartSectionData(
      value: 12,
      color: Colors.teal,
      title: "Clothes",
      radius: 100,
    ),
    PieChartSectionData(
      value: 45,
      color: Colors.purple,
      title: 'Others',
      radius: 100,
    ),
  ];

  late PieChartData pieChartData;

  @override
  void initState() {
    super.initState();
    pieChartData = PieChartData(
      sections: pieCharSections,
      sectionsSpace: 0,
      centerSpaceRadius: 60,
    );
  }

  // Function to update the PieChart data based on API response
  void updatePieChart(List<double> values) {
    setState(() {
      for (int i = 0; i < values.length; i++) {
        pieCharSections[i] = PieChartSectionData(
          value: values[i],
          color: pieCharSections[i].color,
          title: pieCharSections[i].title,
          radius: 100,
        );
      }
      pieChartData = PieChartData(
        sections: pieCharSections,
        sectionsSpace: 0,
        centerSpaceRadius: 60,
      );
    });
  }

  // Example function to simulate fetching data from Firebase
  Future<List<double>> fetchTransactionData() async {
    // Replace this with your actual logic to fetch data from Firebase
    // and calculate the values for each category
    await Future.delayed(
        const Duration(seconds: 2)); // Simulating async data fetch
    List<double> values = [
      40,
      25,
      35,
      20,
      15,
      30
    ]; // Replace with actual values
    return values;
  }

  // Fetch data and update the PieChart
  Future<void> fetchDataAndRefreshChart() async {
    // Fetch data from Firebase
    List<double> firebaseValues = await fetchTransactionData();

    // Update the PieChart with the new values
    updatePieChart(firebaseValues);
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(pieChartData);
  }
}
