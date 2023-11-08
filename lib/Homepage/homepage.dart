import 'package:fintrack_s/Homepage/netexpense.dart';
import 'package:fintrack_s/Homepage/recentTransactions.dart';
import 'package:fintrack_s/Homepage/ThreeButtons/threebuttons.dart';
import 'package:fintrack_s/Provider/navbarprovider.dart';
import 'package:fintrack_s/components/constants.dart';
import 'package:fintrack_s/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Animations/homePageAnimations.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final navprov = Provider.of<NavBarProvider>(context);
    // Scaffold.of(context).isDrawerOpen
    //     ? navprov.setNavStatus(true)
    //     : navprov.setNavStatus(false);
    return Scaffold(
      backgroundColor: appBcgcolor,
      drawer: const OpenDrawer(),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(alignment: Alignment.topLeft, children: const [
                    LogoAtTop(),
                    MenuBtnAtTop(),
                  ]),
                ],
              ),
              // SizedBox(height: 30,child: Text("vedant")),
              const TotalExpense(),
              const SizedBox(height: 30),
              const ThreeButtons(),
              const SizedBox(height: 30),
              const Expanded(child: RecentTransactions()),
            ],
          )),
      onDrawerChanged: (isOpened) {
        if (isOpened) {
          navprov.setNavStatus(true);
        } else {
          navprov.setNavStatus(false);
        }
      },
    );
  }
}

class MenuBtnAtTop extends StatelessWidget {
  const MenuBtnAtTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final navprov = Provider.of<NavBarProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Builder(
        builder: (BuildContext context) {
          return FloatingActionButton(
            backgroundColor: Colors.brown,
            child: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
    );
  }
}

class LogoAtTop extends StatelessWidget {
  const LogoAtTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          width: 300,
          alignment: Alignment.center,
          color: appBcgcolor,
          child: const AppNameAnimation(),
          // child: Image.asset("android/assets/images/app_name_design.png",
          //     fit: BoxFit.fill,
          //     height: 200,
          //     alignment: Alignment.centerRight,
          //     width: 200)
        ),
      ],
    );
  }
}
