
import 'package:blackcoffer_assignment/features/view_video/controller/video_page_controller.dart';
import 'package:blackcoffer_assignment/features/view_video/repository/comments_repository/comment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({super.key , required this.vid });
  final String vid ;

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  Widget build(BuildContext context) {
      return SizedBox(
        height: 300.sp,
        child: StreamBuilder(stream:VideoPageController().getCommentsStream(widget.vid), builder: (context , snapshot ){
          if(snapshot.connectionState  == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          else{
            if(snapshot.hasData){

              return ListView.builder(itemCount: snapshot.data!.comments.length,physics:snapshot.data!.comments.length <= 5 ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),itemBuilder: (context,ind){
                final comment = snapshot.data!.comments[ind] ;
                final diffindays = DateTime.now().difference(comment.dateTime.toDate()).inDays.toString() ;
                final diffinHours = DateTime.now().difference(comment.dateTime.toDate()).inHours.toString() ;

                return SizedBox(

                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(comment.userurl),
                              )
                            ],
                          ),
                          SizedBox(
                          width: 15.sp,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("@${comment.username} • " , style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600
                                  ),),
                                  Text("${diffindays == "0" ?  diffinHours =="0"?  "Just now " :"${diffinHours} hours ago " :diffindays == "1" ? "${diffindays} day ago ":"${diffindays} days ago "}"),

                                ],
                              ),
                              Text(comment.comment),
                            ],
                          ),
                        ],
                      ),const Divider()
                    ],
                  ),

                ) ;
              }) ;
            }
            else{
              return const Center(child: const  Text('No Comments')) ;
            }
          }
        }),
      );
  }
}
