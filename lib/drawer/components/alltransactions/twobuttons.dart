import 'package:fintrack_s/Provider/transactionTypeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TwoButtons extends StatefulWidget {
  const TwoButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<TwoButtons> createState() => _TopTwoButtonsState();
}

class _TopTwoButtonsState extends State<TwoButtons> {
  @override
  Widget build(BuildContext context) {
    final transactypeprovider = Provider.of<TransacTypeProvider>(context);
    print('building again');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            transactypeprovider.changeTransactionType(true);
          },
          style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromWidth(150),
              elevation: 2,
              backgroundColor:
                  transactypeprovider.debited ? Colors.brown : Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18))),
          child: const Text(
            "Debited",
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            transactypeprovider.changeTransactionType(false);
          },
          style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromWidth(150),
              elevation: 2,
              backgroundColor: transactypeprovider.debited ? Colors.grey : Colors.brown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18))),
          child: const Text("Credited", style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }
}
