// To parse this JSON data, do
//
//     final commentList = commentListFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

CommentList commentListFromJson(String str) => CommentList.fromJson(json.decode(str));

String commentListToJson(CommentList data) => json.encode(data.toJson());

class CommentList {
  List<Comment> comments;

  CommentList({
    required this.comments,
  });

  factory CommentList.fromJson(Map<String, dynamic> json) => CommentList(
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
  };
}

class Comment {
  String comment;
  String username;
  String userurl;
  String useruid;
  String vid;
  Timestamp dateTime ;

  Comment({
    required this.comment,
    required this.username,
    required this.userurl,
    required this.useruid,
    required this.vid,
    required this.dateTime
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    comment: json["comment"],
    username: json["username"],
    userurl: json["userurl"],
    useruid: json["useruid"],
    vid: json["vid"],
    dateTime: json["datetime"]
  );

  Map<String, dynamic> toJson() => {
    "comment": comment,
    "username": username,
    "userurl": userurl,
    "useruid": useruid,
    "vid": vid,
    "datetime": dateTime
  };
}
