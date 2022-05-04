import 'package:app_email/screens/login.dart';
import 'package:flutter/material.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();
    _nagivateState();
  }

  void _nagivateState() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset(
            "assets/logo3.png",
            height: 300,
            width: 300,
          ),
        ),
      ),
    );
  }
}
