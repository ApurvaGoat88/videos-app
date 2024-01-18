

import 'dart:ffi';

import 'package:blackcoffer_assignment/models/userdata/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExploreController{



  Future<void>  updateViews(Video videoModel,context)async{
    showDialog(context: context, builder: (context)=>const Center(
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
    ));
    final _ref = await FirebaseFirestore.instance.collection('allvideosdata').doc(videoModel.vid).get();
    var current_views = _ref.get('views') ;
    print(current_views.toString() +"views") ;

    current_views=current_views + 1 ;


     final data = await _ref.data()!;
     print(current_views) ;

    await FirebaseFirestore.instance.collection('allvideosdata').doc(videoModel.vid).update({
      'views':current_views
    });
    Navigator.pop(context);

  }

}