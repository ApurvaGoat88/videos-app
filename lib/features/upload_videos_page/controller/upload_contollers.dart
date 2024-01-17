
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_compress/video_compress.dart';
import 'package:blackcoffer_assignment/common/widgets/snackbar.dart';
import 'package:blackcoffer_assignment/models/userdata/userdata_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class UploadController{

        getThumbnailFile(String path )async{
          final thumbnail = await VideoCompress.getFileThumbnail(path);
          return thumbnail ;
        }

        uploadVideoToFirebase(String vid,String pathname)async{
          final UploadTask task =  FirebaseStorage.instance.ref().child('allvideos').child(vid).putFile( File(pathname)) ;

          final snapshot  = await task ;


          final url = await snapshot.ref.getDownloadURL() ;
          return url ;
        }
        uploadthumbnailToFirebase(String vid,String pathname)async{
          final UploadTask task =  FirebaseStorage.instance.ref().child('allthumbnails').child(vid).putFile(await getThumbnailFile(pathname)) ;

          final snapshot  = await task ;


          final url = await snapshot.ref.getDownloadURL() ;
          return url ;
        }


        saveDatatoFirestore(String userprofilePicture,String location , String des ,String title ,String path , context , String category ,String username,String vid  )async{
          showDialog(context: context, barrierDismissible: false,builder: (context) => Center(
            child:  CircularProgressIndicator(
              color: Colors.black,
            ),
          ));
          try{

            final  videoURL = await uploadVideoToFirebase(vid, path) ;
            final thumbnailURl = await uploadthumbnailToFirebase(vid, path);

            final video = Video( userUrl:  userprofilePicture,videourl: videoURL, videoThumbnail: thumbnailURl, title: title, des: des, category: category, location: location, dateTime: Timestamp.now(), username: username);

            final json  = video.toJson() ;

            print(json) ;
            CollectionReference collectionReference = FirebaseFirestore.instance.collection('allvideosdata');

            await collectionReference.doc(vid).set(json) ;


          Navigator.pop(context) ;
          }catch(e){
            print(e);
            Snack().show(e.toString(),context) ;
          }

        }

        Future<void> updateVideoList(String uid , List<String> list ) async {
          try {
            await FirebaseFirestore.instance.collection('users').doc(uid).update({
              'videos': list,
            });
            print('Field updated successfully');
          } catch (e) {
            print('Error updating field: $e');
          }
        }

}