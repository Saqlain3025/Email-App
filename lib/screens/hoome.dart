import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  Status({Key? key}) : super(key: key);
  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading");
          } else if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          dynamic data = snapshot.data;

          var status = data['status'];
          var m1 = "assets/tank4.png";

          if (status == 0 || status <= 14) {
            m1 = "assets/tank2.png";
          } else if (status == 15 || status <= 29) {
            m1 = "assets/tank3.png";
          } else if (status == 30 || status <= 44) {
            m1 = "assets/tank4.png";
          } else if (status == 45 || status <= 59) {
            m1 = "assets/tank5.png";
          } else if (status == 60 || status <= 74) {
            m1 = "assets/tank6.png";
          } else if (status == 75 || status <= 89) {
            m1 = "assets/tank7.png";
          } else if (status == 90 || status <= 100) {
            m1 = "assets/tank8.png";
          }

          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: 150,
                height: 200,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(
                  m1,
                  fit: BoxFit.contain,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['status'].toString(),
                    style: TextStyle(fontSize: 30),
                  ),
                  Icon(Icons.percent_rounded),
                ],
              ),
            ],
          );
        });
  }
}
