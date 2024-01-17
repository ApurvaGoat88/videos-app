import 'package:blackcoffer_assignment/features/home/screens/home_page.dart';
import 'package:blackcoffer_assignment/features/login/userdetails/controller/userdeatils_controller.dart';
import 'package:blackcoffer_assignment/features/login/userdetails/screen/user_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class UserDeatilsLoink extends StatefulWidget {
  const UserDeatilsLoink({super.key,required this.uid});
  final String uid ;
  @override
  State<UserDeatilsLoink> createState() => _UserDeatilsLoinkState();
}

class _UserDeatilsLoinkState extends State<UserDeatilsLoink> {
  Future<bool> doesDocumentExist( String documentId) async {
    try {
      DocumentReference documentRef = FirebaseFirestore.instance.collection('users').doc(documentId);

      DocumentSnapshot documentSnapshot = await documentRef.get();
      print('checked') ;
      return documentSnapshot.exists;
    } catch (e) {
      print('Error checking document existence: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user  = FirebaseAuth.instance.currentUser ;
    return FutureBuilder<bool>(
      future: doesDocumentExist(user!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          );
        } else {
          if (snapshot.data == true) {
            return const HomePage(); // Return the widget instead of navigating
          } else {
            return UserDetailForm(user:user); // Return the widget instead of navigating
          }
        }
      },
    );
  }
}
