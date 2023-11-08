import 'package:flutter/material.dart';
import 'package:fintrack_s/Services/firebase_services.dart';
import 'package:fintrack_s/Services/sms_services.dart';

class RecentTransactions extends StatefulWidget {
  const RecentTransactions({Key? key}) : super(key: key);

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 20,
              expandedHeight: 30.0,
              pinned: true,
              backgroundColor: Colors.grey,
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1,
                title: const Text("Recent Transactions"),
                background: Container(
                  color: Colors.brown,
                ),
              ),
            ),
            FutureBuilder<List<BankTransaction>>(
              future: fetchAllTransactions(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                }

                List<BankTransaction> transactions = snapshot.data ?? [];

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      BankTransaction transaction = transactions[index];
                      String type = transaction.transactionType;
                      return ListTile(
                        selectedTileColor: Colors.white,
                        tileColor: Colors.white,
                        leading: const Icon(Icons.alarm),
                        title: Text(transaction.receiverName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  type == 'debited' ? 'Send : ' : 'Received : ',
                                ),
                                Text(
                                  transaction.amount,
                                  style: TextStyle(
                                      color: (type == 'debited'
                                          ? Colors.red
                                          : Colors.green)),
                                )
                              ],
                            ),
                            Text('Date: ${transaction.time}'),
                          ],
                        ),
                      );
                    },
                    childCount: transactions.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
