import 'package:blackcoffer_assignment/features/view_user_profile/screen/user_profile_view.dart';
import 'package:blackcoffer_assignment/features/view_video/controller/video_page_controller.dart';
import 'package:blackcoffer_assignment/features/view_video/repository/comments_repository/comment_repository.dart';
import 'package:blackcoffer_assignment/features/view_video/widgets/comments_section.dart';
import 'package:blackcoffer_assignment/models/comments/comment_model.dart';
import 'package:blackcoffer_assignment/models/userdata/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share/share.dart' ;
import 'package:chewie/chewie.dart';
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
  ChewieController?  _chewieController ;
  final _formKey = GlobalKey<FormState>();
  bool liked = false ;
  final _commentController = TextEditingController() ;
  bool disliked = false ;
  bool _isLoading = true;
  String  userUrl = '';

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.video.videourl,))..initialize().then((value) {
      setState(() {
        _isLoading = false ;
      });
    });
   _chewieController = ChewieController(videoPlayerController: _videoController!,
   autoPlay: true ,
     autoInitialize: true,
     looping:  false
   );

  }
  void shareUrl(String url) {
    Share.share('Check out this URL: $url');
  }

  @override
  void dispose() {
    super.dispose();
    _videoController!.dispose();
    _chewieController!.dispose() ;
  }

  @override
  Widget build(BuildContext context) {
    final video = widget.video ;
    final diff  = DateTime.now().difference(video.dateTime.toDate()).inDays.toString() ;
    final diffinHours  = DateTime.now().difference(video.dateTime.toDate()).inHours.toString() ;
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title:const  Text('Video Player'),
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
    child: Chewie(controller: _chewieController!),
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
                    Text('  ${    liked ?  video.likes +1 : video.likes } likes'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(onPressed: ()async{
                      await VideoPageController().updateDisLike(video, context, disliked);
                      setState(() {

                        disliked = !disliked ;
                        if(disliked && liked ){
                          liked = false;
                        }
                      });
                    }, icon: disliked ?  const Icon(Icons.thumb_down_alt_sharp,color: Colors.red,)    :const  Icon(Icons.thumb_down_outlined)),
                    Text('${ disliked ?   video.dislikes+1 : video.dislikes} dislikes'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(onPressed: (){
                      shareUrl(video.videourl) ;
                    }, icon:const  Icon(Icons.share)),
                    const Text('share'),
                  ],
                )
              ],

            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical:10.0.sp , horizontal: 20.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                        Text("${video.views} views • ", style:const TextStyle(
              color: Colors.black,
                  fontSize: 20
              )) ,
                  Text("${diff == "0" ? "${diffinHours} hours ago " :diff == "1" ? "${diff} day ago ":"${diff} days ago "}• " ,style:const TextStyle(
                      color: Colors.black,
                      fontSize: 20
                  )),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Container(
                    margin: EdgeInsets.only(left: 20.sp,right: 5.sp),
                    height: 50.sp,
                    width: 50.sp,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.video.userUrl),
                    ),
                  ),
                  Text("@${video.username}")
                ],


              ),
              SizedBox(
                width: 60.sp,
              ),
              OutlinedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewUserProfile(uid: video.userId,))) ;
              },
                  child:  Row(
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
      SizedBox(

        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${widget.commentList.comments.length} Comments"),
              const Divider(),
              CommentSection(vid: video.vid) ,
            const Divider() ,
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'Add Comment',

                  suffixIcon: IconButton(onPressed: ()async{
                    if (_commentController.text.isNotEmpty) {
                      String comment = _commentController.text.toString();
                      _commentController.clear() ;
                      final uid = FirebaseAuth.instance.currentUser!.uid ;
                       final res = await FirebaseFirestore.instance.collection('users').doc(uid).get();
                        final user = Userdata.fromJson(res.data()!) ;
                     final commentModel =  Comment(comment: comment, username: user.username, userurl: user.imageurls, useruid: user.uid, dateTime: Timestamp.now(),vid: widget.video.vid, ) ;
                      await CommentRepository().postComment(commentModel) ;
                    }
                    else{

                    }
                  },icon:const  Icon(Icons.arrow_upward_outlined,color: Colors.black,),),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]

    ),
      
    )
    );
  }
}

