
import 'package:blackcoffer_assignment/features/upload_videos_page/repository/upload_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userdataProvider = FutureProvider((ref) {
  return ref.watch(uploadRepositoryProvider).retriveUserData() ;
});