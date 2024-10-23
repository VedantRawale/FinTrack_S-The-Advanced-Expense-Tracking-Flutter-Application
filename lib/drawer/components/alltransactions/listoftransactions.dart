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

              // Helper function to convert "20Oct23" to DateTime
              DateTime? parseDate(String time) {
              try {
                // Validate the length of the string
                if (time.length != 7) {
                  return null; // Return null for invalid format
                }

                // Extract the day, month, and year from the string
                int day = int.parse(time.substring(0, 2));
                String monthString = time.substring(2, 5); // "Oct"
                int year = int.parse(time.substring(5, 7)) + 2000; // Assuming the year is in 2000s

                // Map month string to an integer
                Map<String, int> monthMap = {
                  'Jan': 1,
                  'Feb': 2,
                  'Mar': 3,
                  'Apr': 4,
                  'May': 5,
                  'Jun': 6,
                  'Jul': 7,
                  'Aug': 8,
                  'Sep': 9,
                  'Oct': 10,
                  'Nov': 11,
                  'Dec': 12
                };

                int? month = monthMap[monthString];
                if (month == null) {
                  return null; // Return null for invalid month
                }

                // Create DateTime object
                DateTime date = DateTime(year, month, day);

                // Check if the date is valid (day must be within valid range for the month)
                if (date.day != day) {
                  return null; // Return null for invalid date
                }

                return date;
              } catch (e) {
                return null; // Return null for any parsing exceptions
              }
              }

              // Filtering out transactions with valid dates
              var validTransactions = filteredTransactions.where((transaction) {
              return parseDate(transaction.time) != null; // Keep only valid dates
              }).toList();

              // Sorting the valid transactions
              validTransactions.sort((a, b) {
              DateTime aDate = parseDate(a.time)!; // Safe to unwrap since we filtered invalid dates
              DateTime bDate = parseDate(b.time)!; // Safe to unwrap since we filtered invalid dates

              return bDate.compareTo(aDate); // Sort in descending order
              });



              return TransList(filteredTransactions: validTransactions, transtypeprovider: transtypeprovider);
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
