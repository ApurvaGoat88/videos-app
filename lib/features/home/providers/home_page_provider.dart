import 'package:blackcoffer_assignment/features/home/repository/home_page_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locationProvider  = FutureProvider<String>((ref) async {
  final location  = await ref.watch(homeRepositoryProvider).getCurrentLocation() ;
  return location ;
});


final locationProviderforAppBar  = FutureProvider<String>((ref) async {
  final location  = await ref.watch(homeRepositoryProvider).locationforAppbar() ;
  return location ;
});

final locaitonProvider2 = Provider((ref) {
  return ref.watch(homeRepositoryProvider).location ;
});