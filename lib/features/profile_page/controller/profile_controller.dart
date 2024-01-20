import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileController{

  Future<void> deleteFromUserProfile(String vid )async {
    final uid = FirebaseAuth.instance.currentUser!.uid ;
    final store = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final json = store.data()!;
    final videoRefList  =  json['videos'] as List;

    videoRefList.remove(vid) ;

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'videos':videoRefList
    }).then((value) {
      print("$vid removed from $uid user");
    });
    return ;


  }

  Future<void> deleteVideo(String vid,context )async{

    try{
      showDialog(context: context, builder: (context)=> const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ) );
      await deleteFromUserProfile(vid) ;
      await FirebaseFirestore.instance
          .collection('allvideosdata')
          .doc(vid)
          .delete();
      print('Document deleted successfully.');
      Navigator.pop(context) ;

    } catch (e){

      print(e.toString())  ;
    }


  }
}