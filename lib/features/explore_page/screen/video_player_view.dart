import 'package:blackcoffer_assignment/models/userdata/userdata_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ViewVideoScreen extends StatefulWidget {
  const ViewVideoScreen({super.key ,required this.video});
final Video video ;
  @override
  State<ViewVideoScreen> createState() => _ViewVideoScreenState();
}

class _ViewVideoScreenState extends State<ViewVideoScreen> {
  VideoPlayerController? _videoController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.video.videourl,),videoPlayerOptions: VideoPlayerOptions(
    ));
    _videoController!.initialize(
    );
    _videoController!.play();
    _videoController!.setLooping(true );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
    padding: EdgeInsets.all(10.0.sp),
    child: SizedBox(
    width: MediaQuery.sizeOf(context).width,
    height: MediaQuery.sizeOf(context).height / 1.7,
    child: VideoPlayer(_videoController!),
    ),
    )
    ]

    ),
    )
    );
  }
}

