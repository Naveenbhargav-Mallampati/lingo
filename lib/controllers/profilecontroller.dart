import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingo/Backend/Homeapi.dart';
import 'package:lingo/Backend/profileApi.dart';
import 'package:lingo/controllers/AccountController.dart';

final userProfileProvider =
    FutureProvider.autoDispose.family<ProfileModel?, String>((ref, id) {
  return UserProfileApi(ref.watch(databaseProvider), id).GetProfile(id);
});

final SetuserProfileProvider = FutureProvider.autoDispose
    .family<Map<dynamic, dynamic>, ProfileModel>((ref, model) {
  return UserProfileApi(ref.watch(databaseProvider), model.id!)
      .SetProfile(model);
});

final userLoadProvider = StateProvider<bool?>((ref) {
  return false;
});

final dataloadProvider = StateProvider<bool?>((ref) {
  return false;
});

final profileprovider = StateProvider<ProfileModel>((ref) {
  return ProfileModel();
});
