

import 'package:blackcoffer_assignment/features/explore_page/repository/explore_reporistory.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoDataProvider = FutureProvider((ref) async{
  final videoList = await ref.watch(exploreRepoProvider).fetchVideosFromFirestore();
  return videoList ;
});