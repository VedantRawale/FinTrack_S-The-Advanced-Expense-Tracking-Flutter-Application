import 'package:fintrack_s/Provider/transactionProvider.dart';
import 'package:fintrack_s/Provider/transactionTypeProvider.dart';
import 'package:fintrack_s/Services/sms_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Services/firebase_services.dart';

class ListOfTransactions extends StatefulWidget {
  const ListOfTransactions({
    Key? key,
  }) : super(key: key);

  @override
  State<ListOfTransactions> createState() => _ListOfTransactionsState();
}

class _ListOfTransactionsState extends State<ListOfTransactions> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final provider = Provider.of<TransactionProvider>(context);
      final transtypeprovider = Provider.of<TransacTypeProvider>(context);
      return Expanded(
        child: FutureBuilder(
          future: fetchMonthlyTransactions(provider.selectedmonth),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator(color: Colors.grey,));
            } else {
              List<BankTransaction> transactions =
                  snapshot.data as List<BankTransaction>;
              List<BankTransaction> filteredTransactions = transtypeprovider
                      .debited
                  ? transactions
                      .where((transaction) =>
                          transaction.transactionType == 'debited')
                      .toList()
                  : transactions
                      .where((transaction) =>
                          transaction.transactionType == 'credited')
                      .toList();
              filteredTransactions.sort((a, b) =>
                  double.parse(b.time.substring(0, 2))
                      .compareTo(double.parse(a.time.substring(0, 2))));

              return TransList(filteredTransactions: filteredTransactions, transtypeprovider: transtypeprovider);
            }
          },
        ),
      );
    });
  }
}

class TransList extends StatelessWidget {
  const TransList({
    super.key,
    required this.filteredTransactions,
    required this.transtypeprovider,
  });

  final List<BankTransaction> filteredTransactions;
  final TransacTypeProvider transtypeprovider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: filteredTransactions.length,
        itemBuilder: (context, index) {
          return Card(
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 30,
                      child: Image.asset(
                          "android/assets/images/sbi_logo.png"),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            filteredTransactions[index].receiverName),
                        const SizedBox(height: 5),
                        Text(
                          filteredTransactions[index].time,
                          style: const TextStyle(color: Colors.brown),
                        ),
                      ],
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            "\u20B9 ${filteredTransactions[index].amount}",),
                        const SizedBox(height: 5),
                        Text(
                          filteredTransactions[index].category,
                          style: const TextStyle(color: Colors.brown),
                        ),
                      ],
                    ),
                  // Text(
                  //   "\u20B9 ${filteredTransactions[index].amount}",
                  //   style: TextStyle(
                  //       color: transtypeprovider.debited
                  //           ? Colors.red
                  //           : Colors.green),
                  // ),
                  const SizedBox(width: 10),
                ],
              ));
        });
  }
}
