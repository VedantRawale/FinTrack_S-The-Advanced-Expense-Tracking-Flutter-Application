import 'package:flutter/material.dart';

class TopTwoButtons extends StatefulWidget {
  final bool topG, topL;
  final VoidCallback onPressedTopGainers;
  final VoidCallback onPressedTopLosers;

  const TopTwoButtons({
    Key? key,
    required this.topG,
    required this.topL,
    required this.onPressedTopGainers,
    required this.onPressedTopLosers,
  }) : super(key: key);


  @override
  State<TopTwoButtons> createState() => _TopTwoButtonsState();
}

class _TopTwoButtonsState extends State<TopTwoButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
         onPressed: widget.onPressedTopGainers,
          style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromWidth(150),
              elevation: 2,
              backgroundColor: widget.topG ? Colors.brown : Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18))),
          child: const Text(
            "Top Gainers",
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: widget.onPressedTopLosers,
          style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromWidth(150),
              elevation: 2,
              backgroundColor: widget.topG ? Colors.grey : Colors.brown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18))),
          child:
              const Text("Top Loosers", style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }
}
