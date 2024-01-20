
import 'package:blackcoffer_assignment/features/explore_page/controller/explore_page_controller.dart';
import 'package:blackcoffer_assignment/features/explore_page/provider/explore_page_provider.dart';
import 'package:blackcoffer_assignment/features/explore_page/screen/get_video_details_page.dart';
import 'package:blackcoffer_assignment/features/view_video/screens/video_player_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ExplorePage extends ConsumerWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.refresh(videoDataProvider) ;
    final refData = ref.watch(videoDataProvider) ;

        return refData.when(data: (videos){
          // print(videos[0].toJson()) ;
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height:videos.length * 310.sp,
                    child: ListView.builder(physics: const BouncingScrollPhysics(),itemCount: videos.length,reverse: true,itemBuilder: (context,index){
                       final diff  = DateTime.now().difference(videos[index].dateTime.toDate()).inDays.toString() ;
                       final diffinHours  = DateTime.now().difference(videos[index].dateTime.toDate()).inHours.toString() ;

                       return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: ()async {
                           await  ExploreController().updateViews(videos[index], context);
                            Navigator.push(context, PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 600),pageBuilder: (context ,_,__) => GetVideoDataPage(videomodel: videos[index])));
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width.sp,
                            margin: EdgeInsets.only(bottom: 15.sp),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100
                            ),
                            child: Column(
                              children: [


                                SizedBox(



                                  child: Hero(
                                    tag:videos[index].vid ,
                                    child: FadeInImage(
                                      placeholder: const AssetImage('assets/images/login2.png'), // Replace with your placeholder image
                                      image: NetworkImage(videos[index].videoThumbnail, ), // Replace with your actual image URL
                                      fit: BoxFit.fill,
                                      width: MediaQuery.sizeOf(context).width.sp, // Set your desired width
                                      height: 200.0, // Set your desired height

                                      imageErrorBuilder: (context, error, stackTrace) {
                                        return const Center(
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        );
                                      },
                                      // Loading  (CircularProgressIndicator)
                                      placeholderErrorBuilder: (context, error, stackTrace) {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                ),
                                Padding(
                                  padding:  EdgeInsets.all(10.0.sp),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,

                                        children: [
                                          CircleAvatar(

                                            backgroundImage: NetworkImage(videos[index].userUrl),
                                            radius: 25.sp,
                                          ),

                                        ],
                                      )
                                      ,
                                      SizedBox(
                                        width: 20.sp,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(

                                            children: [
                                              SizedBox(

                                                width:250.sp,
                                                child: Text(videos[index].title, maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w600,

                                                  ),),
                                              ),

                                              Text(videos[index].location)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text( "@${videos[index].username}",style: const TextStyle(
                                                color: Colors.black,

                                              ),)
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              Text("${videos[index].views } views •"),
                                              Text("${diff == "0" ?  diffinHours =="0"?  "Just now " :"${diffinHours} hours ago " :diff == "1" ? "${diff} day ago ":"${diff} days ago "}•"),
                                              Text("${videos[index].category } "),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ) ,

                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );

        }, error: (_,__){
          return Container() ;
        }, loading: (){
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        });
  }
}
