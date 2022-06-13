import 'package:app_email/screens/splash_screen.dart';
import 'package:app_email/screens/splash_scren1.dart';
import 'package:app_email/services/connectivity.dart';
import 'package:app_email/services/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  String value = '';

  Future<bool> checkedLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    value = prefs.getString('email')!;

    if (value == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    String string;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
        return FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print("Something went wrongs");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitDualRing(
                    color: Colors.blueAccent,
                    size: 50.0,
                  ),
                );
              }

              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: FutureBuilder(
                  future: checkedLoginStatus(),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData == false) {
                      return SplashScreen1();
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitDualRing(
                          color: Colors.blueAccent,
                          size: 50.0,
                        ),
                      );
                    }
                    return SplashScreen();
                  },
                ),
              );
            });

        break;
      case ConnectivityResult.wifi:
        return FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print("Something went wrongs");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitDualRing(
                    color: Colors.blueAccent,
                    size: 50.0,
                  ),
                );
              }

              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: FutureBuilder(
                  future: checkedLoginStatus(),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData == false) {
                      return SplashScreen1();
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitDualRing(
                          color: Colors.blueAccent,
                          size: 50.0,
                        ),
                      );
                    }
                    return SplashScreen();
                  },
                ),
              );
            });
        break;
      case ConnectivityResult.none:
      default:
        string = 'Offline';
    }
    return SpinKitDualRing(
      color: Colors.blueAccent,
      size: 50.0,
    );
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }
}
