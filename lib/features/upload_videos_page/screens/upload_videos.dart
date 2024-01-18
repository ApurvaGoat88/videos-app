import 'dart:io';
import 'package:blackcoffer_assignment/features/upload_videos_page/controller/upload_contollers.dart';
import 'package:blackcoffer_assignment/models/userdata/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class UploadVideoForm extends ConsumerStatefulWidget {
  const UploadVideoForm({Key? key, required this.file, required this.path,required this.location, required this.usermodel})
      : super(key: key);
  final Userdata usermodel;
  final File file;
  final String path;
  final String location ;

  @override
  _UploadVideoFormState createState() => _UploadVideoFormState();
}

class _UploadVideoFormState extends ConsumerState<UploadVideoForm> {
  VideoPlayerController? _videoController;
  TextEditingController titleController = TextEditingController();

  String dropdownValue = 'Funny';
  List<String> categories = ['Funny', 'Science', 'Technology', 'Education', 'Entertainment', 'Others'];
  TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.file(widget.file);
    _videoController!.initialize(
    );
    _videoController!.play();
    _videoController!.setLooping(false);
  }

  @override
  void dispose() {
    super.dispose();
    _videoController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.usermodel.username) ;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title:const  Text('Add Details'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0.sp),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height / 1.7,
                  child: VideoPlayer(_videoController!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          Text('Categories'),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54, width: 1),
                          ),
                        ),
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                            print(dropdownValue);
                          });
                        },
                        items: ['Funny', 'Science', 'Technology', 'Education', 'Entertainment', 'Others']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style:const  TextStyle(fontSize: 20),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () async{

                          if (_formKey.currentState!.validate()) {
                            String title = titleController.text;
                            String description = descriptionController.text;
                            String location = widget.location ;
                            String category = dropdownValue ;
                            List<String> list = [] ;
                            for(String ref in widget.usermodel.videos){
                              list.add(ref ) ;
                            }
                            String vid = DateTime.now().millisecondsSinceEpoch.toString() ;
                            list.add(vid );
                            UploadController().saveDatatoFirestore(widget.usermodel.imageurls,location, description, title, widget.file.path, context, category,widget.usermodel.username,vid);
                            await  UploadController().updateVideoList(widget.usermodel.uid, list) ;
                          }

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          fixedSize: Size(240.sp, 50.sp)
                        ),
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
