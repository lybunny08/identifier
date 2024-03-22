import 'dart:async';

import 'package:flutter/material.dart';
import 'package:identifier/home.dart';
import 'package:identifier/navbar.dart';

class SplashScreen extends StatefulWidget {
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  const SplashScreen({
    Key? key,
  }) : super(key: key);
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Center(
            child: Image.asset(
              'assets/splashscreen.gif',
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 3,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          const Text('Made by', style: TextStyle(fontWeight: FontWeight.w200)),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Mamitiana HAJANIAINA',
            style: TextStyle(fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
