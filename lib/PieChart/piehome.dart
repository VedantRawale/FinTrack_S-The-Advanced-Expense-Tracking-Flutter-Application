import 'package:fintrack_s/PieChart/piechart.dart';
import 'package:fintrack_s/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PieHome extends StatefulWidget {
  static const String routeName = 'pie';
  const PieHome({super.key});

  @override
  State<PieHome> createState() => _PieHomeState();
}

class _PieHomeState extends State<PieHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBcgcolor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Insights",
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Expanded(child: PChart()),
            const Text("Stationary : ----------"),
            const Text("Stationary : ----------"),
            const Text("Stationary : ----------"),
            const Text("Stationary : ----------"),
            const Text("Stationary : ----------"),
            const Text("Stationary : ----------"),
            const Text("Stationary : ----------"),
            SizedBox(height: 100),
          ],
        ));
  }
}
