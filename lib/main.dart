import 'package:app_email/screens/splash_screen.dart';
import 'package:app_email/screens/splash_scren1.dart';
import 'package:app_email/services/notification.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  String value = '';

  Future<bool> checkedLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    value = prefs.getString('email')!;
    // print('value is : $value');
    if (value == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Something went wrongs");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ScreenUtilInit(
              designSize: Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (child) {
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return SplashScreen();
                      }),
                );
              });
        });
  }
}
