
import 'package:blackcoffer_assignment/features/explore_page/controller/explore_page_controller.dart';
import 'package:blackcoffer_assignment/features/explore_page/screen/get_video_details_page.dart';
import 'package:blackcoffer_assignment/features/view_user_profile/repository/view_user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewUserProfile extends StatefulWidget {
  const ViewUserProfile({super.key  ,required this.uid });
  final String uid ;

  @override
  State<ViewUserProfile> createState() => _ViewUserProfileState();
}

class _ViewUserProfileState extends State<ViewUserProfile> {
  @override
  Widget build(BuildContext context  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,

        // centerTitle: true,
      ),
      body:FutureBuilder(future: ViewUserRepository().getVideoList(widget.uid), builder: (context , snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const  Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
        else{
          if(snapshot.hasData){
            final userdata = snapshot.data! ;


            return  SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Stack(

                        children: [ Container(
                          height: 150.sp,
                          color: Colors.blueAccent,
                        ),Container(
                            alignment: Alignment.center,
                            // color: Colors.pinkAccent,
                            height: 300.sp,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20.sp,
                                ),
                                SizedBox(
                                  height: 20.sp,
                                ),
                                CircleAvatar(
                                  radius: 100.sp,
                                  backgroundImage: NetworkImage(snapshot.data!.first.userUrl),
                                ),
                                SizedBox(
                                  height: 20.sp,
                                ),
                                Text("@${userdata.first.username}" ,style: TextStyle(
                                    fontSize: 20.sp
                                ),) ,
                              ],
                            )
                        ),
                        ]
                    ),
                    const Divider(),
                    SizedBox(

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(

                          children: [
                            Text("${userdata.length} videos ",style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700
                            ),),
                            Icon((Icons.arrow_downward_sharp))
                          ],
                        ),
                      ),
                    ),

                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics()
                        ,
                        itemCount: userdata.length,

                        itemBuilder: (context, index ){
                          final diff  = DateTime.now().difference(userdata[index].dateTime.toDate()).inDays.toString() ;
                          final diffinHours  = DateTime.now().difference(userdata[index].dateTime.toDate()).inHours.toString() ;
                          return GestureDetector(
                            onTap: ()async {
                              await ExploreController().updateViews(userdata[index], context).then((value) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => GetVideoDataPage(videomodel: userdata[index])));

                              });
                            }
                            ,
                            child: Container(
                              width: MediaQuery.sizeOf(context).width.sp,
                              color: Colors.grey.shade200 ,
                              margin: EdgeInsets.all(5),
                              height: 180.sp,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 210.sp,
                                    height: 150.sp,
                                    child:  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: FadeInImage(
                                        placeholder: const AssetImage('assets/images/login2.png'), // Replace with your placeholder image
                                        image: NetworkImage(userdata[index].videoThumbnail, ), // Replace with your actual image URL
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
                                  Expanded(child: Container(width: 210.sp,
                                    height: 150.sp,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,

                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical:8.0),
                                              child: Container(
                                                width: 150.sp,
                                                child: Text(userdata[index].title  ,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                            ),
                                            // IconButton(onPressed: (){}, icon: Icon(Icons.delete)),

                                          ],
                                        ),

                                        SizedBox(
                                          width:  210.sp,

                                          child:Text(
                                            "${userdata[index].views} views • " +
                                                "${diff == "0" ?  diffinHours =="0" ?  "Just now " : "${diffinHours} hours ago " : diff == "1" ? "${diff} day ago " : "${diff} days ago "}• " +
                                                "${userdata[index].category}",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                color: Colors.black
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width:  210.sp,

                                          child:Text(
                                            "${userdata[index].des}",overflow: TextOverflow.ellipsis,maxLines: 1,style:TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.grey.shade600
                                          ) ,
                                          ),
                                        ),
                                      ],
                                    ),

                                  ))


                                ],

                              ),

                            ),
                          ) ;
                        })
                  ],
                ),
              ),
            );
          }
          else{
            return Container(
              color: Colors.red,
            ) ;
          }
        }
      }),
    );
  }
}
