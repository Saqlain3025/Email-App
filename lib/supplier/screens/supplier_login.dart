import 'package:app_email/screens/login.dart';
import 'package:app_email/services/loading.dart';
import 'package:app_email/services/toggle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierLogin extends StatefulWidget {
  SupplierLogin({Key? key}) : super(key: key);

  @override
  State<SupplierLogin> createState() => _SupplierLoginState();
}

class _SupplierLoginState extends State<SupplierLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
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
        emailController.text = value!;
      },
      textInputAction: TextInputAction.done,
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

    final loginButton = Material(
      elevation: 10,
      color: Colors.blue,
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
            signInWithEmailAndPassword(
                emailController.text, passwordController.text);
          }
        },
        child: const Text("Login"),
      ),
    );

    final toggle = Container(
      padding: EdgeInsets.all(2),
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueGrey,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.home,
                  color: Colors.grey,
                ), // <-- Icon
                Text("Consumer"), // <-- Text
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            "|",
            style: TextStyle(
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SupplierLogin()));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.directions_bus,
                  color: Colors.blue,
                ), // <-- Icon
                Text("Supplier",
                    style: TextStyle(
                      color: Colors.blue,
                    )), // <-- Text
              ],
            ),
          ),
        ],
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
                        toggle,
                        SizedBox(
                          height: 200,
                          child: Image.asset(
                            "assets/logo3.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text("Supplier"),
                        const SizedBox(
                          height: 50,
                        ),
                        emailField,
                        const SizedBox(
                          height: 25,
                        ),
                        passwordField,
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
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             RegisterationScreen()));
                              },
                              child: const Text(
                                "SignUP",
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          errorMessage,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => HomeScreen()));
      await prefs.setString('email', userCredential.user!.uid);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";

          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage);
    }
  }
}
