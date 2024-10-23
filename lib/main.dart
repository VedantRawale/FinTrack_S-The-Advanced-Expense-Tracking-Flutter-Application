import 'package:fintrack_s/Provider/dateataddtransaction.dart';
import 'package:fintrack_s/Provider/expenseProvider.dart';
import 'package:fintrack_s/Provider/navbarprovider.dart';
import 'package:fintrack_s/Provider/transactionProvider.dart';
import 'package:fintrack_s/Provider/transactionTypeProvider.dart';
import 'package:fintrack_s/introduction_animation/introduction_animation/introduction_animation_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:fintrack_s/firebase_options.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importance Notification',
    description: 'Description', importance: Importance.high, playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
        ChangeNotifierProvider(
          create: (_) => TransacTypeProvider(),
        ),
        ChangeNotifierProvider(create: (_) => NavBarProvider()),
        ChangeNotifierProvider(
          create: (_) => DateAtAddTransactionProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const IntroductionAnimationScreen(),
      ),
    );
  }
}
