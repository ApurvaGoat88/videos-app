
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blackcoffer_assignment/models/userdata/models.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserDetailController{
      Future<void> uploadUserDataToFirestore(Userdata user,context)async{
          showDialog(context: context, builder: (context)=> Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ) );
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set(user.toJson()) ;
        Navigator.pop(context) ;
      }
      Future<String> uploadImage(File imageFile) async {
        final FirebaseStorage _storage = FirebaseStorage.instance;

        try {
          // Generate a unique filename using the uuid package
          String fileName = Uuid().v4();
          String filePath = 'images/$fileName.jpg';

          // Upload the image to Firebase Storage
          await _storage.ref(filePath).putFile(imageFile);

          // Get the download URL of the uploaded image
          String downloadURL = await _storage.ref(filePath).getDownloadURL();

          return downloadURL;
        } catch (e) {
          print('Error uploading image: $e');
          return '';
        }
      }
}