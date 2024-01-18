// To parse this JSON data, do
//
//     final userdata = userdataFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Userdata userdataFromJson(String str) => Userdata.fromJson(json.decode(str));

String userdataToJson(Userdata data) => json.encode(data.toJson());

class Userdata {
  String imageurls;
  String username;
  String uid;
  String phoneNumber;
  List<String> videos;

  Userdata({
    required this.imageurls,
    required this.username,
    required this.uid,
    required this.phoneNumber,
    required this.videos,
  });

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
    imageurls: json["imageurl"],
    username: json["username"],
    uid: json["uid"],
    phoneNumber: json["phoneNumber"],
    videos: List<String>.from(json["videos"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "imageurl": imageurls,
    "username": username,
    "uid": uid,
    "phoneNumber": phoneNumber,
    "videos": List<dynamic>.from(videos.map((x) => x)),
  };
}

class Video {
  String videourl;
  String videoThumbnail;
  String title;
  String category;
  String location;
  String des ;
  String userUrl ;
  Timestamp dateTime ;
  int views ;
  int likes ;
  int dislikes ;
  String vid ;


  String username ;

  Video({
    required this.videourl,
    required this.videoThumbnail,
    required this.title,
    required this.des,
    required this.category,
    required this.location,
    required this.dateTime,
    required this.username ,
    required this.userUrl,
    required this.views,
    required this.vid,
    required this.dislikes,
    required this.likes,

  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    videourl: json["videourl"],
    videoThumbnail: json["videoThumbnail"],
    title: json["title"],
    des: json['des'],
    username: json['username'],
    category: json["category"],
    location: json["location"],
    dateTime: json['datetime'],
    userUrl: json['userurl'],
    vid: json['vid'],
    views: json['views'] ?? 0,
    dislikes: json['dislikes'] ?? 0,
      likes: json['likes'] ?? 0



  );

  Map<String, dynamic> toJson() => {
    "videourl": videourl,
    "videoThumbnail": videoThumbnail,
    "title": title,
    'des':des,
    'username':username,
    "category": category,
    "location": location,
    'datetime':dateTime,
    'userurl':userUrl,
    'views' : views,
     'vid':vid,
    'likes':likes,
    'dislikes':dislikes
  };
}
