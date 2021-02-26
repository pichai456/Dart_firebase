import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Firebase Authen App", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
             IconButton(
                  icon: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Icon(Icons.logout),
                  ),
                  onPressed: () {
                    auth.signOut();
                    Navigator.pop(context);
                  },
                ),
          ],
        ),
        body: Container(
            child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("Hello", style: TextStyle(fontSize: 26)),
        ]))));
  }
}
