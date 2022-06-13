import 'package:app_email/supplier/screens/supplier_home.dart';
import 'package:app_email/supplier/screens/supplier_order.dart';
import 'package:app_email/supplier/screens/supplier_setting.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  final screen = [
    SupplierHome(),
    SupplierOrder(),
    SupplierSettinf(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("signed In Tea"),
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {},
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: screen[index],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: Colors.white12,
            labelTextStyle:
                MaterialStateProperty.all(TextStyle(color: Colors.white))),
        child: NavigationBar(
          selectedIndex: index,
          backgroundColor: Colors.blueAccent,
          height: 60,
          onDestinationSelected: (index) => setState(() {
            this.index = index;
          }),
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home, color: Colors.white),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.list_alt, color: Colors.white),
              label: "Order",
            ),
            NavigationDestination(
              icon: Icon(Icons.settings, color: Colors.white),
              label: "Setting",
            ),
          ],
        ),
      ),
    );
  }
}
