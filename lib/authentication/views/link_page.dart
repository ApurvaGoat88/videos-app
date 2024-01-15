import 'package:blackcoffer_assignment/features/home/screens/home_page.dart';
import 'package:blackcoffer_assignment/features/login/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class LinkPage extends StatefulWidget {
  const LinkPage({super.key});

  @override
  State<LinkPage> createState() => _LinkPageState();
}

class _LinkPageState extends State<LinkPage> {
  final _auth = FirebaseAuth.instance ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginPage();
          }
        },
      ));
  }
}
