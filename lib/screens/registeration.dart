import 'package:app_email/screens/home.dart';
import 'package:app_email/services/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

import 'login.dart';

class RegisterationScreen extends StatefulWidget {
  const RegisterationScreen({Key? key}) : super(key: key);

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  late final String uid;
  bool loading = false;

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final TextEditingController conformPasswordController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
      autofocus: false,
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
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        hintText: "First Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );

    final lastNameField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.name,
      controller: lastNameController,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Please Enter your Last Name");
        } else if (!regex.hasMatch(value)) {
          return ("Please Enter name of 3 character or more");
        } else {
          return null;
        }
      },
      onSaved: (value) {
        lastNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        hintText: "Last Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );

    final emailField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter your Email");
        } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
            .hasMatch(value)) {
          return ("Please Enter valid email");
        } else {
          return null;
        }
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please Enter your password");
        } else if (!regex.hasMatch(value)) {
          return ("Please Enter password of 6 character");
        } else {
          return null;
        }
      },
      obscureText: true,
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );

    final conformPasswordField = TextFormField(
      autofocus: false,
      controller: conformPasswordController,
      validator: (value) {
        if (conformPasswordController.text != passwordController.text) {
          return "Password do not match";
        }
        return null;
      },
      obscureText: true,
      onSaved: (value) {
        conformPasswordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        hintText: "Conform Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );

    final loginButton = Material(
      elevation: 10,
      color: Colors.blueGrey,
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            registerWithEmailAndPassword(
                emailController.text, passwordController.text);
          }
        },
        child: const Text("SignUP"),
      ),
    );

    return loading
        ? Loading()
        : Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(36),
                  color: Colors.white,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200,
                          child: Image.asset(
                            "assets/logo3.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        firstNameField,
                        const SizedBox(
                          height: 25,
                        ),
                        lastNameField,
                        const SizedBox(
                          height: 25,
                        ),
                        emailField,
                        const SizedBox(
                          height: 25,
                        ),
                        passwordField,
                        const SizedBox(
                          height: 25,
                        ),
                        conformPasswordField,
                        const SizedBox(
                          height: 35,
                        ),
                        loginButton,
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  void registerWithEmailAndPassword(String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailToFirebase()});
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future postDetailToFirebase() async {
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameController.text;
    userModel.lastName = lastNameController.text;
    userModel.password = passwordController.text;

    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    await userCollection
        .doc(user.uid)
        .set(userModel.toMap())
        .then((value) async {
      final prefs = await SharedPreferences.getInstance();
      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
      await prefs.setString('email', user.uid);
    });
    Fluttertoast.showToast(msg: "Account created sucessfully");
  }

//
}
