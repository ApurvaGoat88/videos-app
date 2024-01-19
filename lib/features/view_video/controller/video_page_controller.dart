
import 'dart:convert';

import 'package:blackcoffer_assignment/models/comments/comment_model.dart';
import 'package:blackcoffer_assignment/models/userdata/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VideoPageController{
  Stream<CommentList> getCommentsStream(String vid) {
    final _ref = FirebaseFirestore.instance.collection('comments').doc(vid);

    return _ref.snapshots().map((docSnapshot) {
      final jsonData = docSnapshot.get('comments') as List;
      List<Comment> comments = [];

      if (jsonData != null) {
        for (var json in jsonData) {
          comments.add(Comment.fromJson(json));
        }
        return CommentList(comments: comments);
      } else {
        return CommentList(comments: []);
      }
    });
        }

  Future<CommentList> getCommentsofVideo(String vid) async {
    try {
      final _ref = FirebaseFirestore.instance.collection('comments').doc(vid);

      final docSnapshot = await _ref.get();
      final jsonData = docSnapshot.get('comments') as List;
      print(jsonData) ;
      List<Comment> comments = [];
      if (jsonData != null) {
        for (var json in jsonData){
          comments.add(Comment.fromJson(json ));
        }
        return CommentList(comments: comments);

      } else {
        return CommentList(comments: [
        ]); // Return an empty list if the document is not found or doesn't contain valid data
      }
    }
    catch(e){
      print(e.toString()) ;
      return CommentList(comments: []) ;
    }
  }

  Future<void>  updateLike(Video videoModel,context , bool liked )async {
    showDialog(context: context, builder: (context) =>
    const Center(
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
    ));
    final _ref = await FirebaseFirestore.instance.collection('allvideosdata')
        .doc(videoModel.vid)
        .get();
    var current_likes = _ref.get('likes');
    print(current_likes.toString() + "likes");

    current_likes =  liked ?  current_likes -1 :current_likes + 1;


    final data = await _ref.data()!;
    print(current_likes);

    await FirebaseFirestore.instance.collection('allvideosdata').doc(
        videoModel.vid).update({
      'likes': current_likes
    });
    Navigator.pop(context);
  }
  Future<void>  updateDisLike(Video videoModel,context ,bool disliked )async{
    showDialog(context: context, builder: (context)=>const Center(
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
    ));
    final _ref = await FirebaseFirestore.instance.collection('allvideosdata').doc(videoModel.vid).get();
    var current_dislikes = _ref.get('dislikes') ;
    print(current_dislikes.toString() +"dislikes") ;

      current_dislikes=  disliked == false ? current_dislikes + 1  : current_dislikes - 1;


    final data = await _ref.data()!;
    print(current_dislikes) ;

    await FirebaseFirestore.instance.collection('allvideosdata').doc(videoModel.vid).update({
      'dislikes':current_dislikes
    });
    Navigator.pop(context);

  }
  }
