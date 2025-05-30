import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.lightBlue,
        appBarTheme: AppBarTheme(color: Colors.lightBlue),
      ),
      //Pantalla inicial de la app
      home: PriceScreen(),
    );
  }
}
