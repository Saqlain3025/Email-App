import 'package:app_email/screens/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _nagivateState();
  }

  void _nagivateState() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
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
