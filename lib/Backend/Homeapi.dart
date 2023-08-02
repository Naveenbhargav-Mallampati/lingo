import 'dart:convert';
import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class ProfilesApi extends StateNotifier<List<ProfileModel>> {
  // final Client client;
  final Databases database;

  ProfilesApi(this.database) : super([]) {
    // database = Databases(client);
    GetProfiles();
  }

  Future<User?> getAccount() async {
    try {} on AppwriteException catch (e) {
      log(e.toString());
      return null;
    }
    return null;
  }

  // A function to login the user with email and password
  Future<void> createProfile(
      String email, String password, BuildContext context) async {
    try {} catch (e) {
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
  Future<List<ProfileModel>> GetProfiles() async {
    List<ProfileModel> profiles = [];
    try {
      var list = await database.listDocuments(
          databaseId: 'lingo', collectionId: 'profiles')
        ..documents;

      for (var document in list.documents) {
        ProfileModel model = ProfileModel(
            name: document.data['name'].toString(),
            email: document.data['name'].toString(),
            about: convertList(document.data['about']),
            dob: document.data['dob'].toString(),
            location: document.data['location'].toString(),
            pics: convertList(document.data['pics']),
            quotes: convertList(document.data['quotes']),
            profession: document.data['profession'].toString());
        model.id = document.$id;

        profiles.add(model);

        state = [...state, model];
      }

      return profiles;

      // await Navigator.pushReplacementNamed(
      //     context, CreateAccountPage.routeName);
    } catch (e) {
      log(" Sign Up $e");
      return [];

      // await showDialog(
      //     context: context,
      //     builder: (BuildContext context) => AlertDialog(
      //           title: const Text('Error Occured'),
      //           content: Text(e.toString()),
      //           actions: [
      //             TextButton(
      //                 onPressed: () {
      //                   Navigator.of(context).pop();
      //                 },
      //                 child: const Text("Ok"))
      //           ],
      //         ));
    }
  }

  ///  A function to logout the current user
  Future<void> logout(BuildContext context) async {
    try {
      ///  Delete session is the method to logout the user
      ///  it expects sessionID but by passing 'current' it redirects to
      ///  current loggedIn user in this application
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

  static List<String> convertList(List<dynamic> mlist) {
    List<String> mlist2 = [];
    for (var element in mlist) {
      mlist2.add(element.toString());
    }
    return mlist2;
  }
}

class ProfileModel {
  String? name;
  String? profession;
  String? dob;
  String? email;
  String? id;
  String? location;
  List<String>? quotes = [];
  List<String>? about = [];
  List<String>? pics = [];

  ProfileModel(
      {this.name,
      this.email,
      this.about,
      this.dob,
      this.location,
      this.pics,
      this.id,
      this.quotes,
      this.profession});

  ProfileModel Copy({
    String? name,
    String? profession,
    String? dob,
    String? email,
    String? id,
    String? location,
    List<String>? quotes,
    List<String>? about,
    List<String>? pics,
  }) =>
      ProfileModel(
          name: this.name,
          email: this.email,
          about: this.about,
          dob: this.dob,
          location: this.location,
          pics: this.pics,
          quotes: this.quotes,
          profession: this.profession,
          id: this.id);
  Map<String, dynamic> toJson() {
    const em = JsonEncoder();
    final out = em.convert(this);
    return jsonDecode(out);
  }
}
