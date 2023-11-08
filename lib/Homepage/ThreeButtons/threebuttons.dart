import 'package:fintrack_s/Homepage/ThreeButtons/addtransaction.dart';
import 'package:flutter/material.dart';

class ThreeButtons extends StatelessWidget {
  const ThreeButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AddTransaction();
            }));
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              fixedSize: const Size.fromWidth(80)),
          child: Icon(Icons.add),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              fixedSize: const Size.fromWidth(80)),
          child: Icon(Icons.list),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              fixedSize: const Size.fromWidth(80)),
          child: Icon(Icons.search),
        ),
      ],
    );
  }
}
