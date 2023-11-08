import 'package:fintrack_s/Homepage/ThreeButtons/tablecalender.dart';
import 'package:fintrack_s/Provider/dateataddtransaction.dart';
import 'package:fintrack_s/Services/firebase_services.dart';
import 'package:fintrack_s/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../Services/sms_services.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(20),
                  bottomEnd: Radius.circular(20))),
          backgroundColor: Colors.brown,
          centerTitle: true,
          title: const Center(
            child: Text(
              "Add Transaction",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        backgroundColor: appBcgcolor,
        body: Center(
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.brown,
                child: const AddDetails())));
  }
}

class AddDetails extends StatefulWidget {
  const AddDetails({
    super.key,
  });

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();

  String dropdowninitval = "EXPENSE";
  @override
  Widget build(BuildContext context) {
    final dateprovider = Provider.of<DateAtAddTransactionProvider>(context);
    Future<void> addTransaction() async {
      String type = dropdowninitval;
      String description = descriptionController.text;
      DateTime dt = dateprovider.dateTime;
      String year = dt.year.toString();
      String date = dt.day.toString() +
          monthMap.entries.firstWhere((entry) => entry.value == dt.month).key +
          year.substring(2, 4);
      String amount = amountController.text;
      DatabaseReference databaseReference = FirebaseDatabase.instance
          .ref()
          .child('users/$usrId/transactions')
          .child(dt.month.toString());
      try {
        await databaseReference.child('transactions').push().set({
          'bankName': 'SBI',
          'amount': amount,
          'transactionType': (type == 'INCOME' ? 'credited' : 'debited'),
          'time': date,
          'receiverName': description,
          'referenceNumber': amount,
        });
        print("Transaction added successfully!");
      } catch (error) {
        print("Error:$error");
      }
    }

    return SizedBox(
      height: 600,
      width: 360,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Type : ",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 70,
              ),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return DropdownButton(
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      icon: const Icon(
                        Icons.arrow_downward,
                        color: Colors.black,
                      ),
                      value: dropdowninitval,
                      dropdownColor: Colors.black,
                      items: typeoftransac.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        print(value);
                        setState(() {
                          dropdowninitval = value ?? "EXPENSE";
                        });
                      });
                },
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(children: [
            const SizedBox(
              width: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Description : ",
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: descriptionController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Shop Name / Receiver Name..',
                      border: OutlineInputBorder(),
                    )),
              ),
            )
          ]),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(width: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Date : ",
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
              ),
              const SizedBox(width: 70),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          // print(selectedDay);
                          return TableBasicsExample(
                            calendarFormat: calendarFormat,
                            focusedDay: focusedDay,
                          );
                        });
                  },
                  child: const Icon(Icons.calendar_month)),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Consumer<DateAtAddTransactionProvider>(
                  builder: (context, dateprovider, child) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.black,
                        )),
                        child: Center(
                          child: Text(
                            DateFormat('yyyy-MM-dd')
                                .format(dateprovider.dateTime),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(width: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Amount : ",
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
              ),
              const SizedBox(width: 30),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      controller: amountController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        hintText: 'Enter amount',
                        border: OutlineInputBorder(),
                      )),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    backgroundColor: Colors.black),
                onPressed: () async {
                  await addTransaction();
                },
                child: const Text(
                  "Add Transaction",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
