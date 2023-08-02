import 'dart:developer';
import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:lingo/AppLocal/constants.dart';

class ApiService {
  final Client client = Client();
  Account? account;
  Databases? db;
  late Avatars avatars;
  late Storage storage;
  static ApiService? _instance;

  ApiService._internal() {
    client
        .setEndpoint(AppConstants.endpoint)
        .setProject(AppConstants.projectId);
    account = Account(client);
    db = Databases(client);
    avatars = Avatars(client);
    storage = Storage(client);
  }

  ApiService(Function() _internal);

  static ApiService get instance {
    _instance ??= ApiService._internal();
    return _instance!;
  }

  Future<Uint8List> getAvatar(String name) async {
    final res = await avatars.getInitials(
      name: name,
    );
    return res;
  }

  Future<Uint8List> getImageAvatar(String bucketId, String fileId) async {
    final res = await storage.getFilePreview(
        bucketId: bucketId, fileId: fileId, width: 100);
    return res;
  }

  static Future<models.File> uploadFile(
      String bucketId, InputFile file, Storage storage,
      {List<String> permissions = const []}) async {
    return storage.createFile(
        bucketId: bucketId,
        fileId: ID.unique(),
        file: file,
        permissions: [
          Permission.read(Role.any()),
          Permission.write(Role.any()),
        ]).then((value) {
      print(value.$id);
      return value;
    });
  }
}

///  We have created a class named [Authentication] which contains all
///  the methods that we need to perform the authentication process.
///  ofc You are free to use any name you want
class Authentication {
  late Account account;

  // see that soon
  Authentication(this.account);

  Future<User?> getAccount() async {
    try {
      return await account.get();
    } on AppwriteException catch (e) {
      log(e.toString());
      return null;
    }
  }

  // A function to login the user with email and password
  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      await account.createEmailSession(email: email, password: password);

      //await Navigator.pushReplacementNamed(context, HomePage.routename);
    } catch (e) {
      // print(e);
      await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Error Occured'),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"))
                ],
              ));
    }
  }

  ///  A function to signup the user with email and password
  Future<void> signUp(
    String email,
    String password,
    BuildContext context, {
    String name = '',
  }) async {
    try {
      if (name.isNotEmpty) {
        await account.create(
            email: email, password: password, name: name, userId: 'unique()');
      } else {
        await account
            .create(email: email, password: password, userId: 'unique()')
            .then((value) {});
      }

      await account.createEmailSession(email: email, password: password);
      print('create email session');

      // await Navigator.pushReplacementNamed(
      //     context, CreateAccountPage.routeName);
    } catch (e) {
      log(" Sign Up $e");
      await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Error Occured'),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"))
                ],
              ));
    }
  }

  ///  A function to logout the current user
  Future<void> logout(BuildContext context) async {
    try {
      ///  Delete session is the method to logout the user
      ///  it expects sessionID but by passing 'current' it redirects to
      ///  current loggedIn user in this application
      await account.deleteSession(sessionId: 'current');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Logged out Successfully"),
        duration: Duration(seconds: 2),
      ));
      // await Navigator.of(context).pushReplacementNamed(LoginPage.routename);
    } catch (e) {
      // print(e);
      await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Something went wrong'),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"))
                ],
              ));
    }
  }
}
