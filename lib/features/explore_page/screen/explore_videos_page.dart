
import 'package:blackcoffer_assignment/features/explore_page/controller/explore_page_controller.dart';
import 'package:blackcoffer_assignment/features/explore_page/provider/explore_page_provider.dart';
import 'package:blackcoffer_assignment/features/explore_page/screen/get_video_details_page.dart';
import 'package:blackcoffer_assignment/features/explore_page/screen/video_player_view.dart';
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
            body: SizedBox(
              height:videos.length * 340.sp,
              child: ListView.builder(physics: const BouncingScrollPhysics(),itemCount: videos.length,itemBuilder: (context,index){
                 final diff  = videos[index].dateTime.toDate().difference(DateTime.now()).inDays.toString() ;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: ()async {
                     await  ExploreController().updateViews(videos[index], context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GetVideoDataPage(videomodel: videos[index])));
                    },
                    child: Card(
                      child: Container(
                        width: MediaQuery.sizeOf(context).width.sp,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100
                        ),
                        child: Column(
                          children: [

                            Padding(
                              padding: EdgeInsets.only(bottom:10.0.sp),
                              child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2
                                )
                              ),child: Image.network(videos[index].videoThumbnail,fit: BoxFit.fill,height: 200.sp,width: MediaQuery.sizeOf(context).width.sp,)),
                            ) ,
                            Padding(
                              padding:  EdgeInsets.all(10.0.sp),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: 21.sp),
                                        child:
                                            CircleAvatar(

                                              backgroundImage: NetworkImage(videos[index].userUrl),
                                              radius: 20.sp,
                                            ),


                                      ),
                                      Expanded(
                                        child: Text(videos[index].title, style: TextStyle(
                                          fontSize: 25.sp,fontWeight: FontWeight.bold,

                                        ),maxLines: 1,
                                        overflow: TextOverflow.ellipsis,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                           const  Icon(Icons.location_pin,size: 15,),
                                            SizedBox(width: 3.sp,),
                                            Text(videos[index].location,style: TextStyle(
                                              color: Colors.grey.shade800
                                            ),),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.sp),
                                        child:
                                        Text( "@${videos[index].username }",style: TextStyle(
                                          color: Colors.grey.shade500
                                        ),) ,


                                      ),
                                      Expanded(child: Container(
                                        child:  Text("${videos[index].views} views"),
                                      )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text( diff == '0' ? 'Today' : "$diff Days ago", style:const TextStyle(
                                              color: Colors.grey
                                            ),),

                                            SizedBox(width: 15.sp,),
                                            const Icon(Icons.category),
                                            SizedBox(width: 5.sp,),
                                            Text(videos[index].category),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ) ,
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
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
