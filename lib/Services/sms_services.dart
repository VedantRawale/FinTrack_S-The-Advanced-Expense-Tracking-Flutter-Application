import 'dart:core';
import 'package:fintrack_s/Services/firebase_services.dart';
import 'package:telephony/telephony.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:permission_handler/permission_handler.dart';

import '../components/constants.dart';

// sms_services.dart
double netDebited = 0;
double netCredited = 0;
Map<int, double> monthwiseNetCredited = {};
Map<int, double> monthwiseNetDebited = {};
Map<int, List<Map<String, dynamic>>> monthwiseTransactions = {};
String defcat = "Others";

Future<void> rescanAndSaveSms() async {
  Telephony telephony = Telephony.instance;
  var status = await Permission.sms.request();
  netDebited = 0;
  netCredited = 0;
  monthwiseNetCredited = {};
  monthwiseNetDebited = {};
  monthwiseTransactions = {};

  if (status.isGranted) {
    List<SmsMessage> messages = await telephony.getInboxSms(
      columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
      filter: SmsFilter.where(SmsColumn.ADDRESS)
          .equals("AX-SBIUPI")
          .or(SmsColumn.ADDRESS)
          .equals("CP-SBIUPI")
          .or(SmsColumn.ADDRESS)
          .equals("AD-SBIUPI"),
    );
    // log(messages.length.toString());
    for (var message in messages) {
      BankTransaction? transaction = parseSms(message.body.toString());
      if (transaction != null) {
        // Save the transaction data to Firebase
        print(message.body);
        if (transaction.time.length < 7) {
          print(
              "${transaction.transactionType} ${transaction.amount} ${transaction.time}");
          continue;
        }
        int month = monthMap[transaction.time.substring(2, 5)] ?? 0;
        double amt = double.parse(transaction.amount);
        if (transaction.transactionType == 'debited') {
          netDebited += amt;
          monthwiseNetDebited[month] = (monthwiseNetDebited[month] ?? 0) + amt;
        } else {
          netCredited += amt;
          monthwiseNetCredited[month] =
              (monthwiseNetCredited[month] ?? 0) + amt;
        }
        //----------testing-------
        if (monthwiseTransactions[month] == null) {
          monthwiseTransactions[month] = [];
        }
        print(month);
        monthwiseTransactions[month]!.add({
          'bankName': transaction.bankName,
          'amount': transaction.amount,
          'transactionType': transaction.transactionType,
          'time': transaction.time,
          'receiverName': transaction.receiverName,
          'category': defcat,
        });
        //-------------previous------
        // saveTransactionData(transaction);
      }
    }
    await saveTransaction();
  }
}

class BankTransaction {
  String bankName;
  String amount;
  String transactionType;
  String time;
  String receiverName;
  String category;
  BankTransaction(
      {required this.bankName,
      required this.amount,
      required this.transactionType,
      required this.time,
      required this.receiverName,
      required this.category});

  factory BankTransaction.fromMap(Map<dynamic, dynamic> map) {
    return BankTransaction(
      amount: map['amount'] ?? '0.0',
      bankName: map['bankName'] ?? '',
      receiverName: map['receiverName'] ?? '',
      category: map['category'] ?? '',
      time: map['time'] ?? '',
      transactionType: map['transactionType'] ?? '',
    );
  }
}

Future saveTransaction() async {
  DatabaseReference userTransactionsRef = FirebaseDatabase.instance
      .ref()
      .child('users/$usrId')
      .child('transactions');

  try {
    for (int i = 1; i <= 12; i++) {
      if (monthwiseTransactions[i] == null) continue;
      print("$i-----${monthwiseTransactions[i]!.length}");

      DatabaseReference monthReference =
          userTransactionsRef.child(i.toString());

      await monthReference.child('netCredited').set(monthwiseNetCredited[i]);
      await monthReference.child('netDebited').set(monthwiseNetDebited[i]);

      // Push all transactions for the month
      DatabaseReference monthTransactionsReference =
          monthReference.child('transactions');
      monthTransactionsReference.remove();
      for (var transactionData in monthwiseTransactions[i]!) {
        await monthTransactionsReference.push().set(transactionData);
      }

      // Update 'netCredited' and 'netDebited' values for the month
      //  await monthReference.child('netCredited').set(monthwiseNetCredited[i]);
      //   await monthReference.child('netDebited').set(monthwiseNetDebited[i]);
    }

    // Set aggregated data for all months combined
    await userTransactionsRef.child('netCredited').set(netCredited);
    await userTransactionsRef.child('netDebited').set(netDebited);

    print('Transaction data saved successfully.');
  } catch (error) {
    print('Error saving transaction data: $error');
  }
}

BankTransaction? parseSms(String sms) {
  final RegExp credRegex = RegExp(
    r"Dear SBI UPI User, ur A/c([A-Za-z0-9]+) (?<typecred>[A-Za-z]+) by Rs([+-]?(?:\d+)?(?:\.?\d*))"
    r"(?: on ([A-Za-z0-9]+))?"
    r"(?: by  \(Ref no (\d+)\))?",
    caseSensitive: false,
  );

  final RegExpMatch? credmatch = credRegex.firstMatch(sms);
  if (credmatch != null) {
    return BankTransaction(
      receiverName: '',
      transactionType: 'credited',
      amount: credmatch.group(3) ?? "0.0",
      time: credmatch.group(4) ?? "",
      category: credmatch.group(5) ?? "",
      bankName: 'SBI',
    );
  }

  final RegExp debRegex = RegExp(
    r"Dear UPI user A/C ([A-Za-z0-9]+) (?<typedeb>[A-Za-z]+) by ([+-]?(?:\d+)?(?:\.?\d*))"
    r"(?: on date ([A-Za-z0-9]+))?"
    r"(?: trf to ([A-Za-z0-9]+(?: [A-Za-z]+)*)(?: Refno (\d+)))"
    r"\.(?: If not u\? call 1800111109)?\.?(?: -([A-Za-z]+))?",
    caseSensitive: false,
  );

  // Match regex against input
  final RegExpMatch? debmatch = debRegex.firstMatch(sms);

  if (debmatch != null) {
    return BankTransaction(
      transactionType: debmatch.group(2) ?? "",
      amount: debmatch.group(3) ?? "0.0",
      time: debmatch.group(4) ?? "",
      receiverName: debmatch.group(5) ?? "",
      category: debmatch.group(6) ?? "",
      bankName: 'SBI',
    );
  } else {
    return null;
  }
}


