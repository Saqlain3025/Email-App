import 'package:app_email/models/user.dart';
import 'package:app_email/services/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth.dart';
import 'hoome.dart';
import 'login.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthServices _auth = AuthServices();

  User? user = FirebaseAuth.instance.currentUser;

  UserModel loginUser = UserModel();

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loginUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      // m1,
                      "assets/logo3.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Status(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${loginUser.firstName}  ${loginUser.lastName}",
                    style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "${loginUser.email}",
                    style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ActionChip(
                      label: const Text("Logout"),
                      onPressed: () async {
                        await _auth.signOut();
                        final prefs = await SharedPreferences.getInstance();
                        final success = await prefs.remove('email');

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                        String value = '';
                        value = prefs.getString('email')!;
                      }),
                ]),
          ),
        ),
      ),
    );
  }
}
