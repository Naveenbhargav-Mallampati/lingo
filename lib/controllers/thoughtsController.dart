import 'package:lingo/Backend/thoughtsApi.dart';
import 'package:lingo/controllers/AccountController.dart';
import 'package:riverpod/riverpod.dart';

final ThoughtApiProvider = Provider<ThoughtsApi>((ref) {
  return ThoughtsApi(ref.watch(databaseProvider), '');
});

final ThoughtssProvider = StateNotifierProvider.autoDispose
    .family<ThoughtsApi, List<ThoughtsModel>, String>((ref, collection) {
  return ThoughtsApi(ref.watch(databaseProvider), '');
});

final thoughtcreated =
    FutureProvider.family<String?, String>(((ref, thought) async {
  return ref.read(ThoughtApiProvider).sendThought(thought);
}));

final thoughtSendStatus = StateProvider<bool>((ref) {
  return false;
});

final thoughttap = StateProvider<bool>((ref) {
  return false;
});
