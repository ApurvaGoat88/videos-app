import 'dart:io';

import 'package:blackcoffer_assignment/features/home/screens/home_page.dart';
import 'package:blackcoffer_assignment/features/login/userdetails/controller/userdeatils_controller.dart';
import 'package:blackcoffer_assignment/models/userdata/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
class UserDetailForm extends StatefulWidget {
  const UserDetailForm({super.key ,required this.user});
  final User user ;

  @override
  State<UserDetailForm> createState() => _UserDetailFormState();
}

class _UserDetailFormState extends State<UserDetailForm> {
  File? _profilePicture;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilePicture = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final user = widget.user ;
    print(user.phoneNumber) ;
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body:  SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                 backgroundImage:_profilePicture != null ? FileImage(_profilePicture! ): null ,
                 child:_profilePicture == null ?    Icon(Icons.person,size: 100.sp,):null,
                ),
                SizedBox(height: 20.sp,),
                  ElevatedButton(onPressed: _pickImage,
                      child: _profilePicture == null ? const Text("Choose") : const Text("Change"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white
                        ,
                      fixedSize: Size(200.sp, 40.sp)

                    ),
                  ),



                const SizedBox(height: 100),
               const  Row(
                  children: [
                    Text("Create a Username")
                  ],
                ),
                SizedBox(height: 10.sp,),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username',border: OutlineInputBorder()),

                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),

             const    SizedBox(height: 30),
                const  Row(
                  children: [
                    Text("Add a email ")
                  ],
                ),
                SizedBox(height: 10.sp,),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email',border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(onPressed: ()async{
                  if (_formKey.currentState!.validate()) {
                   if(_profilePicture != null){
                     await UserDetailController().uploadImage(_profilePicture!).then((value) async {
                       final usermodel  = Userdata(imageurls: value, username: _usernameController.text, uid: widget.user.uid, phoneNumber: widget.user.uid, videos: []);
                       await UserDetailController().uploadUserDataToFirestore(usermodel, context) ;
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomePage()));

                     });

                   }
                  }
                },
                  child: const Text("Get Started"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white
                      ,
                      fixedSize: Size(200.sp, 40.sp)

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

