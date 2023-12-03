import 'dart:convert';

import 'package:fintrack_s/Services/sms_services.dart';
import 'package:fintrack_s/components/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:developer';

String usrId = "";
Future<List<BankTransaction>> fetchAllTransactions() async {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('users/$usrId');
  DatabaseEvent databaseEvent = await databaseReference
      .child('transactions')
      .child((DateTime.now().month - 1).toString())
      .child('transactions')
      .once();
  // print((DateTime.now().month - 1).toString());

  List<BankTransaction> transactions = [];
  DataSnapshot dataSnapshot = databaseEvent.snapshot;
  Map<dynamic, dynamic> transactionMap =
      dataSnapshot.value as Map<dynamic, dynamic>;

  transactionMap.forEach((key, value) {
    transactions.add(BankTransaction.fromMap(value));
  });
  return transactions;
}

// Future<List<double>> getNetExpense() async {
//   DatabaseReference databaseReference =
//       FirebaseDatabase.instance.ref().child('users/$usrId');
//   DatabaseEvent databaseEvent1 = await databaseReference
//       .child('transactions')
//       .child((DateTime.now().month - 1).toString())
//       .child('transactions')
//       .once();
//   DatabaseEvent databaseEvent2 = await databaseReference
//       .child('transactions')
//       .child((DateTime.now().month - 1).toString())
//       .child('transactions')
//       .once();
//   double val1 = 0.0;
//   double val2 = 0.0;

//   if (databaseEvent1.snapshot.value != null) {
//     val1 = databaseEvent1.snapshot.value as double;
//   }
//   if (databaseEvent2.snapshot.value != null) {
//     val2 = databaseEvent2.snapshot.value as double;
//   }

//   return [val1, val2];
// }

Future<List<double>> getNetExpense(int month) async {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('users/$usrId');
  if (month == 0) {
    try {
      DatabaseEvent cred = await databaseReference
          .child('transactions')
          .child('netCredited')
          .once();
      DatabaseEvent deb = await databaseReference
          .child('transactions')
          .child('netDebited')
          .once();
      double creditedValue = (cred.snapshot.value == null
          ? 0.0
          : double.parse(cred.snapshot.value.toString()));
      double debitedValue = (deb.snapshot.value == null
          ? 0.0
          : double.parse(deb.snapshot.value.toString()));
      return [creditedValue, debitedValue];
    } catch (error) {
      log(error.toString());
      throw Exception("Failed to fetch transactions");
    }
  } else {
    DatabaseEvent creditedEvent = await databaseReference
        .child('transactions')
        .child(month.toString())
        .child('netCredited')
        .once();

    DatabaseEvent debitedEvent = await databaseReference
        .child('transactions')
        .child(month.toString())
        .child('netDebited')
        .once();

    double creditedValue = (creditedEvent.snapshot.value == null
        ? 0.0
        : double.parse(creditedEvent.snapshot.value.toString()));
    double debitedValue = (debitedEvent.snapshot.value == null
        ? 0.0
        : double.parse(debitedEvent.snapshot.value.toString()));
    return [creditedValue, debitedValue];
  }
}

Future<List<BankTransaction>> fetchMonthlyTransactions(String month) async {
  try {
    if (month == 'AllMonths') {
      List<BankTransaction> transactions = [];
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref().child('users/$usrId/transactions');
      for (int i = 1; i <= 12; i++) {
        DatabaseEvent databaseEvent = await databaseReference
            .child(i.toString())
            .child('transactions')
            .once();
        DataSnapshot dataSnapshot = databaseEvent.snapshot;
        if (dataSnapshot.value != null) {
          Map<dynamic, dynamic> transactionMap =
              dataSnapshot.value as Map<dynamic, dynamic>;
          transactionMap.forEach((key, value) {
            transactions.add(BankTransaction.fromMap(value));
          });
        }
      }
      return transactions;
    }

    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('users/$usrId');
    DatabaseEvent databaseEvent = await databaseReference
        .child('transactions')
        .child(monthMap[month].toString())
        .child('transactions')
        .once();

    List<BankTransaction> transactions = [];
    DataSnapshot dataSnapshot = databaseEvent.snapshot;
    Map<dynamic, dynamic> transactionMap =
        dataSnapshot.value as Map<dynamic, dynamic>;

    transactionMap.forEach((key, value) {
      transactions.add(BankTransaction.fromMap(value));
    });

    return transactions;
  } catch (error) {
    // Handle errors, log them, or throw a custom exception.
    print("Error fetching transactions: $error");
    throw Exception("Failed to fetch transactions");
  }
}

// Future addProductCategory(String category, double amount) async {
//   DatabaseReference userTransactionsRef = FirebaseDatabase.instance
//       .ref()
//       .child('users/$usrId')
//       .child('categories/$category');
//   DatabaseEvent databaseEvent = await userTransactionsRef.once();
//   DataSnapshot dataSnapshot = databaseEvent.snapshot;

//   try {
//     if (dataSnapshot.value != null) {
//       await userTransactionsRef.set(amount + (dataSnapshot.value as int));
//     } else {
//       await userTransactionsRef.set(amount);
//     }
//   } catch (error) {
//     print("Error adding category amount: $error");
//     throw Exception("Failed to add category amount");
//   }
// }
