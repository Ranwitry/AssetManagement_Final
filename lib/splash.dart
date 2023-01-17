import 'dart:async';
import 'package:flutter/material.dart';
import '/main.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  session() async {
    await gs.read('login');
    if (gs.read('login') == true) {
      Navigator.pushReplacementNamed(context, '/menu');
    }
  }

  void startTimer() async {
    Timer(Duration(seconds: 4), () {
      session();
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/splash.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
