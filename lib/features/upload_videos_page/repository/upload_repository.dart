
import 'package:blackcoffer_assignment/models/userdata/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class UploadRepository{
  String _locationMessage = '';
  Future<Userdata> retriveUserData()async{
    final uid = await FirebaseAuth.instance.currentUser!.uid ;
    final ref = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    print('data rsadsa as');
    final json = ref.data()! ;
    return Userdata.fromJson(json as Map<String,dynamic>) ;

  }
}

final uploadRepositoryProvider = Provider<UploadRepository>((ref) => UploadRepository()) ;