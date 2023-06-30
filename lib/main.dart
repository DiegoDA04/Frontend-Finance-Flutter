import 'package:finance_flutter/offers/ui/offers/offersView.dart';
import 'package:finance_flutter/offers/ui/payment_cronogram/payment_cronogram.dart';
import 'package:finance_flutter/offers/ui/schedule_payment/schedule_payment_view.dart';
import 'package:finance_flutter/security/ui/login/login_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinanceApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const LoginView(),
    );
  }
}
