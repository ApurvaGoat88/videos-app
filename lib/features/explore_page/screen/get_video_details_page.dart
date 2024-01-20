import 'package:blackcoffer_assignment/features/view_video/controller/video_page_controller.dart';
import 'package:blackcoffer_assignment/features/view_video/screens/video_player_view.dart';
import 'package:blackcoffer_assignment/models/comments/comment_model.dart';
import 'package:blackcoffer_assignment/models/userdata/models.dart';
import 'package:flutter/material.dart';

class GetVideoDataPage extends StatefulWidget {
  const GetVideoDataPage({super.key ,required this.videomodel});
  final Video videomodel ; 

  @override
  State<GetVideoDataPage> createState() => _GetVideoDataPageState();
}

class _GetVideoDataPageState extends State<GetVideoDataPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CommentList>(
        future:  VideoPageController().getCommentsofVideo(widget.videomodel.vid),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
          body:  Hero(
            tag: widget.videomodel.vid,
            child: Center(
                child:  CircularProgressIndicator()),
          ),
        ); // Show a loading indicator while fetching data
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot
            .error}'); // Show an error message if there's an error
      } else {
        CommentList comments = snapshot.data ?? CommentList(comments: []);
        return ViewVideoScreen(video: widget.videomodel, commentList: comments);
      }
      
    }
    );
    
  }
}
