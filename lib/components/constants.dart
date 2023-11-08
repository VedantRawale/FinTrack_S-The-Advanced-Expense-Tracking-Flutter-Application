import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const appBcgcolor = const Color(0xffF7EBE1);
const appBcgcolor2 = const Color(0xFFDBD9DB);

const double defaultPadding = 16.0;

Map<String, int> monthMap = {
  "AllMonths": 0,
  "Jan": 1,
  "Feb": 2,
  "Mar": 3,
  "Apr": 4,
  "May": 5,
  "Jun": 6,
  "Jul": 7,
  "Aug": 8,
  "Sep": 9,
  "Oct": 10,
  "Nov": 11,
  "Dec": 12,
};

List<String> monthList = [
  "AllMonths",
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];

 final RegExp combinedRegex = RegExp(
    r"Dear SBI UPI User, ur A/c([A-Za-z0-9]+)\s+(?<typecred>[A-Za-z]+)\s+by Rs([+-]?(?:\d+)?(?:\.?\d*))\s*"
    r"(?: on ([A-Za-z0-9]+))?\s*"
    r"(?: by \(Ref no (\d+)\))?"
    r"|"
    r"Dear UPI user A/C ([A-Za-z0-9]+) (?<typedeb>[A-Za-z]+) by ([+-]?(?:\d+)?(?:\.?\d*))"
    r"(?: on date ([A-Za-z0-9]+))?"
    r"(?: trf to ([A-Za-z0-9]+(?: [A-Za-z]+)*)(?: Refno (\d+)))"
    r"\.(?: If not u\? call 1800111109)?\.?(?: -([A-Za-z]+))?",
    caseSensitive: false,
  );

  var typeoftransac = [
  "EXPENSE",
  "INCOME",
  "TRANSFER",
  "ATM WITHDRAWAL",
  "CASHBACK",
  "REFUND"
];