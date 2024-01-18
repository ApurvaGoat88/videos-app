import 'package:blackcoffer_assignment/features/explore_page/controller/video_page_controller.dart';
import 'package:blackcoffer_assignment/models/comments/comment_model.dart';
import 'package:blackcoffer_assignment/models/userdata/models.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ViewVideoScreen extends StatefulWidget {
  const ViewVideoScreen({super.key ,required this.video ,required this.commentList
  });
final Video video ;
final CommentList commentList ;
  @override
  State<ViewVideoScreen> createState() => _ViewVideoScreenState();
}

class _ViewVideoScreenState extends State<ViewVideoScreen> {
  VideoPlayerController? _videoController;
  final _formKey = GlobalKey<FormState>();
  bool liked = false ;
  bool disliked = false ;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.video.videourl,),videoPlayerOptions: VideoPlayerOptions(
    ));
    _videoController!.initialize(
    );
    _videoController!.play();
    _videoController!.setLooping(false );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final video = widget.video ;
    final diff  = video.dateTime.toDate().difference(DateTime.now()).inDays.toString() ;
    final diffinHours  = DateTime.now().difference(video.dateTime.toDate()).inHours.toString() ;
    return Scaffold(
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
    padding: EdgeInsets.symmetric(vertical:10.0.sp),
    child: SizedBox(
    width: MediaQuery.sizeOf(context).width,
    height: MediaQuery.sizeOf(context).height / 1.7,
    child: VideoPlayer(_videoController!),
    ),
    ),
      const Divider(),


      SizedBox(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(vertical:8.0 ,horizontal: 20.sp),
              child: Text(video.title,maxLines: 3,overflow: TextOverflow.ellipsis,style: const TextStyle(
                fontSize: 24,

                fontWeight: FontWeight.bold
              ),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              

              children: [
                Column(
                  children: [
                    IconButton(onPressed: ()async{
                      await VideoPageController().updateLike(video, context, liked);
                      setState(() {
                        liked = !liked ;
                        if(disliked && liked ){
                          disliked = false;
                        }
                      });
                    }, icon:liked ?  const Icon(Icons.thumb_up_alt_sharp,color: Colors.green,)    :const  Icon(Icons.thumb_up_outlined)),
                    Text('${video.likes} likes'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(onPressed: ()async{
                      await VideoPageController().updateLike(video, context, disliked);
                      setState(() {

                        disliked = !disliked ;
                        if(disliked && liked ){
                          liked = false;
                        }
                      });
                    }, icon: disliked ?  const Icon(Icons.thumb_down_alt_sharp,color: Colors.red,)    :const  Icon(Icons.thumb_down_outlined)),
                    Text('${video.dislikes} dislikes'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(onPressed: (){}, icon:const  Icon(Icons.share)),
                    const Text('share'),
                  ],
                )
              ],

            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical:8.0.sp , horizontal: 20.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                        Text("${video.views} views | ", style:const TextStyle(
              color: Colors.black,
                  fontSize: 20
              )) ,
                 Text( diff == '0' ? '$diffinHours hours ago | ' : "$diff Days ago | ", style:const TextStyle(
              color: Colors.black,
          fontSize: 20
        ),),
                  Text( video.location, style:const TextStyle(
                      color: Colors.black,
                      fontSize: 20
                  ),),
                ],
              ),
            ),
          ],
        ),
      ),
      const Divider(),
      Container(
        // height: 200.sp,
          child:
          Row(

            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.sp),
                    height: 100.sp,
                    width: 100.sp,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.video.userUrl),
                    ),
                  ),
                  Text("@${video.username}")
                ],
                

              ),
              SizedBox(
                width: 100.sp,
              ),
              OutlinedButton(onPressed: (){},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('All Videos'),
                      Icon(Icons.arrow_right_outlined)
                    ],

                  ),
                style: OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero
                  ),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,

                  fixedSize:Size(180.sp, 30.sp)
                ),
              ),
            ],
          )
      ),
      const Divider(),
    ]

    ),
    )
    );
  }
}

