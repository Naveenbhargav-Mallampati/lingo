import 'package:lingo/Backend/Homeapi.dart';
import 'package:lingo/controllers/AccountController.dart';
import 'package:riverpod/riverpod.dart';

final profile = Provider<ProfilesApi>((ref) {
  return ProfilesApi(ref.watch(databaseProvider));
});

final ProfilesProvider = FutureProvider.autoDispose
    .family<List<ProfileModel>, String>((ref, collection) {
  return ProfilesApi(ref.watch(databaseProvider)).GetProfiles();
});

final hide = StateProvider((ref) {
  return true;
});
