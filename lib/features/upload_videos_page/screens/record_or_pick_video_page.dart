import 'dart:io';

import 'package:blackcoffer_assignment/common/widgets/snackbar.dart';
import 'package:blackcoffer_assignment/features/upload_videos_page/provider/upload_provider.dart';
import 'package:blackcoffer_assignment/models/userdata/userdata_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'upload_videos.dart';


class UploadVideoPage extends ConsumerWidget {
  const UploadVideoPage({super.key ,required this.location });
final String location ;
  getVideoFile(ImageSource source ,context,Userdata usermodel )async{
    final file = await ImagePicker().pickVideo(source: source) ;

    if(file!=null){

      Navigator.push(context, MaterialPageRoute(builder: (context) => UploadVideoForm(file: File(file.path),path: file.path,location:location,usermodel: usermodel,))) ;
    }
    else{
      Snack().show('No File Selected', context) ;
    }
  }

  displayDialogBox(context , Userdata usermodel ){
  return showDialog(context: context, builder: (context){
    return SimpleDialog(
      children: [
        SimpleDialogOption(
          onPressed: ()async{
            await   getVideoFile(ImageSource.gallery,context,usermodel);

          },
          child:const Row(
            children: [
              Icon(Icons.video_library),
              Text("Pick From Gallery"),
            ],
          ),
        ),
        SimpleDialogOption(
          onPressed: ()async{
            await getVideoFile(ImageSource.camera,context,usermodel);
          },
          child:const Row(
            children: [
              Icon(Icons.video_call_rounded),
              Text("Open Camera"),
            ],
          ),
        ),
        SimpleDialogOption(
          onPressed: (){
            Navigator.pop(context) ;
          },
          child:const Row(
            children: [
              Icon(Icons.cancel),
              Text("Cancel"),
            ],
          ),
        ),
      ],
    );
  });
  }

  @override
  Widget build(BuildContext context , ref ) {
    final future = ref.watch(userdataProvider) ;
    return Scaffold(
      body: future.when(data: (data){
        return Container(
          alignment: Alignment.center,
          color: Colors.white54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center
            ,
            children: [
              GestureDetector(onTap: ()async{
                await displayDialogBox(context ,data);
              },child: Image.asset('assets/images/upload.jpg')),

            ],
          ),
        ) ;
      }, error:(e,st){
        print(e.toString());
        print(st.toString());
        return Container(
          child: Center(
            child: Text("UnExpected Error Occured",style: TextStyle(
              fontSize: 30.sp,

            ),),
          ),
        ) ;
      }, loading:(){
        return Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      })
    );
  }
}
