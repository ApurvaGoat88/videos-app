import 'package:blackcoffer_assignment/common/widgets/snackbar.dart';
import 'package:blackcoffer_assignment/features/home/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key,required this.verificationID});
final verificationID ;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100.sp,
            ),
            Image.asset('assets/images/otp.jpg',height: 300.sp,),
            SizedBox(
              height: 100.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 25.sp),
                  child: Text('Enter OTP\n',style: TextStyle(fontSize: 30.sp ,fontWeight: FontWeight.bold,color: Colors.black))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0,left: 18,right: 18),
              child: TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.phone,
                decoration:const  InputDecoration(
                  labelText: 'OTP',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: ()async{

                    String phoneNumber = _otpController.text.trim();
                    String fullNumber = '$phoneNumber';
                    print('Full Number: $fullNumber');
                    try{
                     PhoneAuthCredential credential = await  PhoneAuthProvider.credential(verificationId: widget.verificationID.toString(), smsCode: _otpController.text.toString()) ;
                     await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomePage())) ;
                     });
                    }
                    on FirebaseException catch (e){
                        if(e.code == 'invalid-verification-code'){
                          Snack().show('Invalid Verificaion code', context);
                        }
                        else{
                          Snack().show('Something went wrong ', context);
                        }
                    }


                  }, child: const Text("Verify"),style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      fixedSize: Size(200.sp, 50.sp),
                      shape:  RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(25.sp)

                      )
                  ),),
                  ElevatedButton(onPressed: (){

                    String phoneNumber = _otpController.text.trim();
                    String fullNumber = '$phoneNumber';
                    print('Full Number: $fullNumber');


                  }, child: const Text("Resend OTP"),style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      fixedSize: Size(200.sp, 50.sp),
                      shape:  RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(25.sp)

                      )
                  ),),
                ],
              ),
            ),
            SizedBox(
              height: 100.sp,
            ),
          ],
        ),
      ),
    );
  }
}
