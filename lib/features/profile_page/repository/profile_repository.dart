
import 'package:blackcoffer_assignment/models/userdata/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileRepository{
  Future<Userdata> getUserdata(String uid )async{
    final ref  = await FirebaseFirestore.instance.collection('users').doc(uid).get() ;
    final json = ref.data()!;

    return Userdata.fromJson(json) ;

  }
  Future<List<Video>> getVideoList(uid )async {
    final user  = await getUserdata(uid );
    print(user.username) ;
    List<Video> userVideos =[] ;
    print(user.videos) ;
    final userVideoRefs = user.videos ;
    final allvideosGET = await FirebaseFirestore.instance.collection('allvideosdata').get();
    final allvideos = allvideosGET.docs;

    for (String vid in userVideoRefs){
      for(QueryDocumentSnapshot videojson in allvideos){
        if (videojson.get('vid') == vid){
          final video = Video.fromJson(videojson.data()! as Map<String, dynamic>);
          userVideos.add(video) ;
        }
      }
    }

    return userVideos ;

  }
}