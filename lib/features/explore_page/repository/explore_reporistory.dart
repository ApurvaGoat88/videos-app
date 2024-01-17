

import 'package:blackcoffer_assignment/models/userdata/userdata_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class ExploreRepository{


  Future<List<Video>> fetchVideosFromFirestore() async
  {
    List<Video> videolist = [];
    try {

      final snapshots = await FirebaseFirestore.instance.collection(
          'allvideosdata').get();
      final videodata = snapshots.docs;

      for (int i = 0; i < videodata.length; i++) {
        QueryDocumentSnapshot<Map<String, dynamic>> items = videodata[i];

        final video = Video.fromJson(items.data()) ;
        videolist.add(video) ;
      }


    }
    catch(ex){
      print(ex.toString()) ;
    }
    return videolist ;

  }
}

final exploreRepoProvider = Provider((ref) => ExploreRepository()) ;