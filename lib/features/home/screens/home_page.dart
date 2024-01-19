import 'package:blackcoffer_assignment/features/home/providers/home_page_provider.dart';
import 'package:blackcoffer_assignment/features/explore_page/screen/explore_videos_page.dart';
import 'package:blackcoffer_assignment/features/profile_page/screens/profile_page.dart';
import 'package:blackcoffer_assignment/features/upload_videos_page/screens/record_or_pick_video_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sweet_nav_bar/sweet_nav_bar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {


  List<Color> gradient = [
    Colors.black ,
    Colors.grey.shade500,
    Colors.grey.shade300
  ];
  int index = 0 ;
  @override
  Widget build(BuildContext context) {
    final locationforAppBar = ref.watch(locationProviderforAppBar);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: locationforAppBar.when(data: (data) {
          return Row(
            children: [
              Text(data),
              SizedBox(
                width: 10.sp,
              ),
              const Icon(Icons.pin_drop_rounded)
            ],
          );
        }, error: (_, __) {
          return Container();
        }, loading: () {
          return Container();
        }),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const  Icon(Icons.logout_outlined))
        ],
      ),bottomNavigationBar: SweetNavBar(

        borderRadius: 0,
      height: 40,
      currentIndex: index,
      paddingBackgroundColor: Colors.transparent,
      items: [
        SweetNavBarItem(
          sweetActive: const Icon(Icons.home),
          sweetIcon: const Icon(
            Icons.home_outlined,
          ),
          sweetLabel: 'Home',),
        SweetNavBarItem(
            sweetIcon: const Icon(Icons.add), sweetLabel: 'Business'),
        SweetNavBarItem(
            sweetIcon: const Icon(Icons.video_library_outlined), sweetActive: const Icon(Icons.video_library_rounded),sweetLabel: 'School'),
      ],
      onTap: (ind) {
        setState(() {
          index = ind;
        });
      },
    ),
      body: locationforAppBar.when(data: (data){
        return Container(child:  [
          ExplorePage(),
          UploadVideoPage(location: data,),
          ProfilePage() ,
        ] [index]) ;
      }, error:(_,__){}, loading: (){
        return const Center(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.black,
              ),
              Text("Getting Location")
            ],
          ),
        );
      })
    );
  }
}
