import 'package:app_email/screens/login.dart';
import 'package:app_email/supplier/screens/supplier_login.dart';
import 'package:flutter/material.dart';

class SwitchUsers extends StatefulWidget {
  SwitchUsers({Key? key}) : super(key: key);

  @override
  State<SwitchUsers> createState() => _SwitchUsersState();
}

class _SwitchUsersState extends State<SwitchUsers> {
  @override
  Widget build(BuildContext context) {
    //consumer side
    final cButton = Material(
      child: SizedBox.fromSize(
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
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
        ),
      ),
    );

    //Supplier side
    final gButton = Material(
      child: SizedBox.fromSize(
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SupplierLogin()));
              setState(() {});
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.directions_bus,
                  color: Colors.grey,
                ), // <-- Icon
                Text("Supplier"), // <-- Text
              ],
            ),
          ),
        ),
      ),
    );

    return Container(
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
          cButton,
          const SizedBox(width: 10),
          const Text(
            "|",
            style: TextStyle(
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(width: 10),
          gButton,
        ],
      ),
    );
  }
}
