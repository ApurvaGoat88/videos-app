

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/comments/comment_model.dart';

class CommentRepository{




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

    Future<void> postComment(Comment comment) async{
    try {
      final _ref = FirebaseFirestore.instance.collection('comments').doc(
          comment.vid);
      final docSnapshot = await _ref.get();
      List<Comment> comments = [];

      final b = docSnapshot.exists;
      if(b) {
        final jsonData = docSnapshot.get('comments') as List ?? [];
        if (jsonData != null) {
          for (var json in jsonData) {
            comments.add(Comment.fromJson(json));
          }
          comments.add(comment);

          // comments.add(comment) ;
          await _ref.set(CommentList(comments: comments).toJson());
        }
      }
      else {
        comments.add(comment);
        await _ref.set(CommentList(comments: comments).toJson());
      }



    }
    on FirebaseException catch (e){
      print(e.message.toString() + "sdasd") ;
    }
      }
    }





final commentRepositoryProvider = Provider<CommentRepository>((ref) => CommentRepository()) ;