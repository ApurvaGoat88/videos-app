import 'package:blackcoffer_assignment/common/widgets/snackbar.dart';
import 'package:blackcoffer_assignment/features/home/screens/home_page.dart';
import 'package:blackcoffer_assignment/features/login/screens/user_details_linkpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key,required this.verificationID , required this.phoneNumber});
final verificationID ;
final String phoneNumber ;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController() ;
  Future<void> resendCode(String phoneNumber, String verificationId, resendToken) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          print('Verification Completed');
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verification Failed: $e');
        },
        codeSent: (String newVerificationId, int? newResendToken)async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setInt('resendToken', resendToken ?? 0);
        },
        codeAutoRetrievalTimeout: (String newVerificationId) {
          print('Auto-Retrieval Timeout');
        },
        forceResendingToken:resendToken,
      );
    } catch (e) {
      print('Error resending code: $e');
    }
  }
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
                       final user = value.user ;
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  UserDeatilsLoink(uid: user!.uid ))) ;
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
                  ElevatedButton(onPressed: ()async{
                    final prefs = await SharedPreferences.getInstance() ;
                    final resendToken = prefs.getInt('resendToken') ;
                    print(resendToken) ;

                    resendCode(widget.phoneNumber,widget.verificationID, resendToken);


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
