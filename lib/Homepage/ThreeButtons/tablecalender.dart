import 'package:fintrack_s/Provider/dateataddtransaction.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'utils.dart';
import 'package:provider/provider.dart';

class TableBasicsExample extends StatefulWidget {
  CalendarFormat calendarFormat;
  DateTime focusedDay;

  TableBasicsExample({
    super.key,
    required this.calendarFormat,
    required this.focusedDay,
  });

  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  @override
  Widget build(BuildContext context) {
    final dateprovider = Provider.of<DateAtAddTransactionProvider>(context);
    print(dateprovider.dateTime);
    return Dialog(
      child: SizedBox(
        height: 450,
        child: Column(
          children: [
            TableCalendar(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: widget.focusedDay,
              calendarFormat: widget.calendarFormat,
              selectedDayPredicate: (day) {
                // Use `selectedDayPredicate` to determine which day is currently selected.
                // If this returns true, then `day` will be marked as selected.

                // Using `isSameDay` is recommended to disregard
                // the time-part of compared DateTime objects.
                return isSameDay(dateprovider.dateTime, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(dateprovider.dateTime, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  setState(() {
                    dateprovider.setDate(selectedDay);
                    widget.focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (widget.calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  setState(() {
                    widget.calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                widget.focusedDay = focusedDay;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      dateprovider.setDate(DateTime.now());
                      Navigator.of(context).pop();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
