import 'package:fintrack_s/drawer/components/livemarket/listofstocks.dart';
import 'package:fintrack_s/drawer/components/livemarket/toptwobuttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveNse extends StatefulWidget {
  const LiveNse({super.key});

  @override
  State<LiveNse> createState() => _LiveNseState();
}

class _LiveNseState extends State<LiveNse> {
  bool topG = true;
  bool topL = false;
  void onPressedTopGainers() {
    setState(() {
      topG = true;
      topL = false;
    });
  }

  void onPressedTopLosers() {
    setState(() {
      topL = true;
      topG = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(height: 30),
        const NiftyFiftyCard(),
        const SizedBox(
          height: 30,
        ),
        TopTwoButtons(
          key: widget.key,
          topG: topG,
          topL: topL,
          onPressedTopGainers: onPressedTopGainers,
          onPressedTopLosers: onPressedTopLosers,
        ),
        const SizedBox(height: 20),
        ListOfStocks(topG: topG),
      ]),
    );
  }
}

class NiftyFiftyCard extends StatelessWidget {
  const NiftyFiftyCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        color: Colors.brown,
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: 50,
                child: Image.asset("android/assets/images/nifty_50.png")),
            const SizedBox(
              width: 20,
            ),
            Text(
              "NIFTY 50",
              style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
