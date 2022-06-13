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
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();

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
                      label: const Text("Update"),
                      onPressed: () {
                        updateProfile();
                      }),
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

  Future updateProfile() async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Your Name"),
          content: TextFormField(
            autofocus: true,
            keyboardType: TextInputType.name,
            controller: firstNameController,
            validator: (value) {
              RegExp regex = new RegExp(r'^.{3,}$');
              if (value!.isEmpty) {
                return ("Please Enter your First Name");
              } else if (!regex.hasMatch(value)) {
                return ("Please Enter name of 3 character or more");
              } else {
                return null;
              }
            },
            onSaved: (value) {
              firstNameController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              hintText: "Enter your first name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final docUser = FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid);
                docUser.update({'firstName': firstNameController.text});
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Text("Save"),
            )
          ],
        ),
      );
}
