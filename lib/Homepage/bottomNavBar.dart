import 'package:fintrack_s/PieChart/piehome.dart';
import 'package:fintrack_s/Provider/navbarprovider.dart';
import 'package:fintrack_s/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'homepage.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final navprovider = Provider.of<NavBarProvider>(context);
    return Scaffold(
      backgroundColor: appBcgcolor,
      body: PersistentTabView(
        context,
        controller: PersistentTabController(initialIndex: 0),
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: "Home",
            activeColorPrimary: Colors.brown,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.pie_chart_sharp),
            title: "Favorites",
            activeColorPrimary: Colors.brown,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.search),
            title: "Search",
            activeColorPrimary: Colors.brown,
            inactiveColorPrimary: Colors.grey,
          ),
          // PersistentBottomNavBarItem(
          //   icon: Icon(Icons.person),
          //   title: "Profile",
          //   activeColorPrimary: Colors.deepOrange,
          //   inactiveColorPrimary: Colors.grey,
          // ),
        ],
        hideNavigationBar: navprovider.hidenavbar,
        screens: [
          // Add your screen widgets here
          const HomePage(),
          const PieHome(),
          Container(color: appBcgcolor),
          // Container(color: Colors.deepOrange),
        ],
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.blue,
        ),
        popAllScreensOnTapOfSelectedTab: false,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        ),
        navBarStyle: NavBarStyle.style9, // You can choose different styles
      ),
    );
  }
}
