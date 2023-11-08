import 'package:fintrack_s/components/constants.dart';
import 'package:flutter/material.dart';

import '../../../Homepage/bottomNavBar.dart';

class SmsScanningScreen extends StatefulWidget {
  final Future<void> Function() rescanAndSaveSms;

  const SmsScanningScreen({Key? key, required this.rescanAndSaveSms})
      : super(key: key);

  @override
  _SmsScanningScreenState createState() => _SmsScanningScreenState();
}

class _SmsScanningScreenState extends State<SmsScanningScreen> {
  late bool _loadingCompleted;

  @override
  void initState() {
    super.initState();
    _loadingCompleted = false;

    // Perform SMS scanning in the background
    widget.rescanAndSaveSms().then((_) {
      if (mounted) {
        setState(() {
          _loadingCompleted = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBcgcolor,
      body: _loadingCompleted ? buildSuccessScreen() : buildLoadingScreen(),
    );
  }

  Widget buildSuccessScreen() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'SMS Parsing Done !',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 25,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const BottomNavBar();
              }));
            },
            child: const Text(
              "Let's Start",
              style: TextStyle(color: Colors.white),
            ))
      ]),
    );
  }

  Widget buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Scanning SMS...',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 25),
          LinearProgressIndicator(),
        ],
      ),
    );
  }
}

Widget buildErrorScreen(String error) {
  return Center(
    child: Text(
      'Error: $error',
      style: const TextStyle(fontSize: 20, color: Colors.red),
    ),
  );
}
