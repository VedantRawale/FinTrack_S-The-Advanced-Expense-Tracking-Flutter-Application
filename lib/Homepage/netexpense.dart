import 'package:fintrack_s/Services/firebase_services.dart';
import 'package:fintrack_s/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import '../Provider/expenseProvider.dart';

class TotalExpense extends StatefulWidget {
  const TotalExpense({super.key});

  @override
  State<TotalExpense> createState() => _TotalExpenseState();
}

class _TotalExpenseState extends State<TotalExpense> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<double>>(
      future: getNetExpense(DateTime.now().month - 1),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return SizedBox(
            child: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }
        double netDebited = snapshot.data![1];
        double netCredited = snapshot.data![0];
        Provider.of<ExpenseProvider>(context)
            .setExpense(netCredited, netDebited);
        return TotalExpenseWidget(
            netDebited: netDebited, netCredited: netCredited);
      },
    );
  }
}

class TotalExpenseWidget extends StatelessWidget {
  final double netDebited;
  final double netCredited;

  const TotalExpenseWidget({
    Key? key,
    required this.netDebited,
    required this.netCredited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: appBcgcolor,
          height: 190,
          width: 300,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              shadowColor: Colors.black,
              color: Colors.brown,
              elevation: 4,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Net Expense",
                            style: GoogleFonts.openSans(
                                color: Colors.white, fontSize: 30)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 14.0),
                        child: Text("This Month",
                            style: GoogleFonts.openSans(
                                color: appBcgcolor, fontSize: 10)),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Material(
                          type: MaterialType.transparency,
                          elevation: 2,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 3.0, left: 3.0),
                                    // child: FutureBuilder<List<BankTransaction>>(
                                    // future: fetchAllTransactions(),
                                    child: AnimatedTextKit(
                                      animatedTexts: [
                                        TyperAnimatedText(
                                            'Rs.${(expenseProvider.netDebited) - (expenseProvider.netCredited)}',
                                            textStyle: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                            )),
                                      ],
                                      repeatForever: true,
                                      totalRepeatCount: 3,
                                      isRepeatingAnimation: true,
                                      pause: const Duration(seconds: 1),
                                    )),
                              )
                            ],
                          ))),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Material(
                      surfaceTintColor: Colors.grey,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Net Credited :",
                              style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Rs.${expenseProvider.netCredited}",
                              style: GoogleFonts.openSans(
                                  color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Material(
                      surfaceTintColor: Colors.red,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Net Debited  :",
                              style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Rs.${expenseProvider.netDebited}",
                              style: GoogleFonts.openSans(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ],
    );
  }
}
