import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Backend/accountApi.dart';

final clientProvider = Provider<Client>((ref) {
  return Client()
      .setEndpoint('https://10.0.2.2/v1') // Your Appwrite Endpoint
      .setProject('lingo') // Your project ID
      .setSelfSigned(
          status:
              true); // For self signed certificates, only use for development
});

final databaseProvider = Provider<Databases>(((ref) {
  final client = ref.watch(clientProvider);
  return Databases(client);
}));

final AccountProvider = Provider<Account>(((ref) {
  final client = ref.watch(clientProvider);
  return Account(client);
}));

final StorageProvider = Provider<Storage>((ref) {
  final client = ref.watch(clientProvider);
  return Storage(client);
});

//  So this is where we defined auth providers

//  Let's have a look at authProvider
//  you will notice I am consuming another provider within a provider
//  and its totally ok, there aren't performance issues to this
//  this authProvider provides an Object of class Authentication
final authProvider = Provider<Authentication>((ref) {
  return Authentication(ref.watch(AccountProvider));
});

///  This is a future Provider which ofc involves a future
///  we are accessing getAccount here which will either return a User object
///  if it's logged In and null if it's not
final userProvider = FutureProvider<User?>((ref) async {
  return ref.watch(authProvider).getAccount();
});

final loading = StateProvider<bool>((ref) {
  return false;
});

/// This is a state provider which is a bit different from the other providers
///  So this  is a provider which decides which widget to show, either welcome screen
///  or Home Screen
///  so think of this like a switch. If the user is logged in show one screen
///  otherwise show other screen
/// When the state changes the widget is rebuilt automatically
///  Keep it null so that we would be able to show the loading screen
final userLoggedInProvider = StateProvider<bool?>((ref) {
  return false;
});
