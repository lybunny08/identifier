import 'package:flutter/material.dart';
import 'package:identifier/cat_widget/catPage.dart';
import 'package:identifier/dog_widget/dogPage.dart';
import 'package:identifier/splashScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SplashScreen(),
      ),
    );
  }
}
