import 'package:fintrack_s/Provider/transactionProvider.dart';
import 'package:fintrack_s/Provider/transactionTypeProvider.dart';
import 'package:fintrack_s/Services/firebase_services.dart';
import 'package:fintrack_s/components/constants.dart';
import 'package:fintrack_s/drawer/components/alltransactions/listoftransactions.dart';
import 'package:fintrack_s/drawer/components/alltransactions/twobuttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    print("parent building");
    final transacType = Provider.of<TransacTypeProvider>(context);
    return Scaffold(
      backgroundColor: appBcgcolor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.brown),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FloatingActionButton.small(
                      backgroundColor: Colors.grey,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back,color: Colors.black)),
                  const SizedBox(
                    width: 65,
                  ),
                  const Text(
                    "Month: ",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(width: 10),
                  const Flexible(child: MonthsDropDown()),
                  // MonthsDropDown(),
                ],
              )),
          const SizedBox(height: 20),
          const TwoButtons(),
          const SizedBox(height: 20),
          Center(
              child: Container(
            height: 40,
            width: 320,
            decoration: BoxDecoration(
                color: Colors.brown, borderRadius: BorderRadius.circular(20)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              transacType.debited
                  ? (const Text(
                      "Net Debited: ",
                      style: TextStyle(color: Colors.white),
                    ))
                  : (const Text(
                      "Net Credited:   ",
                      style: TextStyle(color: Colors.white),
                    )),
              const NetExp(),
            ]),
          )),
          const SizedBox(height: 10),
          const ListOfTransactions(),
        ],
      ),
    );
  }
}

class NetExp extends StatelessWidget {
  const NetExp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final transacType = Provider.of<TransacTypeProvider>(context);
    final transacMonth = Provider.of<TransactionProvider>(context);
    return FutureBuilder(
        future: getNetExpense(monthMap[transacMonth.selectedmonth]!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            List<double> expense = snapshot.data!;
            return transacType.debited
                ? Text(
                    '${expense[1]}',
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )
                : Text(
                    '${expense[0]}',
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  );
          }
        });
  }
}

class MonthsDropDown extends StatefulWidget {
  const MonthsDropDown({super.key});

  @override
  State<MonthsDropDown> createState() => _MonthsDropDownState();
}

class _MonthsDropDownState extends State<MonthsDropDown> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        final monthlistprov = Provider.of<TransactionProvider>(context);
        return DropdownButton(
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
            icon: const Icon(
              Icons.arrow_downward,
              color: Colors.black,
            ),
            value: monthlistprov.selectedmonth,
            dropdownColor: Colors.black,
            items: monthList.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(
                  items,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
            onChanged: (String? value) {
              monthlistprov.setSelectedMonth(value!);
            });
      },
    );
  }
}

// class MonthsDropDown extends StatefulWidget {
//   const MonthsDropDown({super.key});

//   @override
//   State<MonthsDropDown> createState() => _MonthsDropDownState();
// }

// class _MonthsDropDownState extends State<MonthsDropDown> {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<TransactionProvider>(context, listen: false);
//     return DropdownMenu<String>(
//       enableFilter: false,
//       enableSearch: false,
//       menuHeight: 400,
//       initialSelection: provider.selectedmonth,
//       onSelected: (String? value) async {
//         if (value != null && monthList.contains(value)) {
//            provider.setSelectedMonth(value);
//           FocusManager.instance.primaryFocus?.unfocus();
//           print(value);
//         }
//       },
//       dropdownMenuEntries:
//           monthList.map<DropdownMenuEntry<String>>((String value) {
//         return DropdownMenuEntry<String>(
//           value: value,
//           label: value,
//         );
//       }).toList(),
//       inputDecorationTheme: null,
//     );
//   }
// }
