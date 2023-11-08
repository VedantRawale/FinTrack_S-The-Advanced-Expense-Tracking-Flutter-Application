import 'package:fintrack_s/components/constants.dart';
import 'package:fintrack_s/drawer/components/alltransactions/listoftransactions.dart';
import 'package:fintrack_s/drawer/components/alltransactions/transactionscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Animations/drawerIconAnimations.dart';
import '../../Services/sms_services.dart';
import 'components/livemarket/livemarket.dart';

class OpenDrawer extends StatelessWidget {
  const OpenDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppInfo(
              userName: "Vedant Rawale",
            ),
            Container(
              color: appBcgcolor,
              padding: const EdgeInsets.all(24),
              child: Wrap(
                children: const [
                  AllTransactions(),
                  Divider(
                    color: Colors.black54,
                    thickness: 1,
                  ),
                  RescanSms(),
                  Divider(
                    color: Colors.black54,
                    thickness: 1,
                  ),
                  LiveMarket(),
                  Divider(
                    color: Colors.black54,
                    thickness: 1,
                  ),
                  SetBudget(),
                  Divider(
                    color: Colors.black54,
                    thickness: 1,
                  ),
                  Bills(),
                  Divider(
                    color: Colors.black54,
                    thickness: 1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 50,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Made With ",
                        style: GoogleFonts.architectsDaughter(
                            color: Colors.black, fontSize: 20),
                      ),
                      const LoveIcon(),
                    ],
                  )),
            )
          ],
        )),
      );
}

class Bills extends StatelessWidget {
  const Bills({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(color: Colors.black),
      child: ListTile(
        leading: const Icon(Icons.file_present, color: Colors.teal),
        title: Text(
          'Bills',
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        onTap: () => {},
      ),
    );
  }
}

class SetBudget extends StatelessWidget {
  const SetBudget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(color: Colors.black),
      child: ListTile(
        leading: const Icon(Icons.monetization_on, color: Colors.teal),
        title: Text(
          'Set Budget',
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        onTap: () => {},
      ),
    );
  }
}

class LiveMarket extends StatelessWidget {
  const LiveMarket({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(color: Colors.black),
      child: ListTile(
        leading: const Icon(Icons.bar_chart, color: Colors.teal),
        title: Text(
          'Live Market',
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        onTap: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const LiveNse()))
        },
      ),
    );
  }
}

class RescanSms extends StatelessWidget {
  const RescanSms({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(color: Colors.black),
      child: ListTile(
        leading: const Icon(Icons.search, color: Colors.teal),
        title: Text(
          'Rescan SMS',
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        onTap: () async {
          rescanAndSaveSms();
        },
      ),
    );
  }
}

class AllTransactions extends StatelessWidget {
  const AllTransactions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(color: Colors.black),
      child: ListTile(
        leading: const Icon(Icons.note_alt, color: Colors.teal),
        title: Text(
          'All Transactions',
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        onTap: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => const TransactionScreen()))),
        },
      ),
    );
  }
}

class AppInfo extends StatelessWidget {
  final String userName;
  const AppInfo({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        color: Colors.brown,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // const CircleAvatar(
            //   radius: 60,
            //   backgroundImage: AssetImage("android/assets/images/app_logo.png"),
            // ),
           Flexible(child: AppLogo(radius: 60,)),
            // const SizedBox(height: ),
            Text(
              userName,
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Track your expense easily !',
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ));
  }
}
