import 'package:bank_app_alura/pages/transfer/transfer_insert_page.dart';
import 'package:bank_app_alura/pages/transfer/transfer_listing_page.dart';
import 'package:bank_app_alura/styles/themes_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemesApp.primaryThemeApp,
      debugShowCheckedModeBanner: false,
      initialRoute: "/transfer",
      routes: {
        "/transfer": (context) => const TransferListingPage(),
        "/transfer/insert": (context) => TransferInsertPage(),
      },
    );
  }
}