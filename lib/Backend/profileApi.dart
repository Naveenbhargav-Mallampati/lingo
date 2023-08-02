import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:lingo/Backend/Homeapi.dart';

class UserProfileApi {
  // final Client client;
  final Databases database;
  final String id;
  //ProfileModel state = ProfileModel();

  UserProfileApi(this.database, this.id) : super() {
    // database = Databases(client);
    GetProfile(id);
  }

  Future<Map<dynamic, dynamic>> SetProfile(ProfileModel model) async {
    try {
      var document = await database.createDocument(
          databaseId: 'lingo',
          collectionId: 'profiles',
          documentId: ID.unique(),
          data: model.toJson());
      print(document.data);
      return document.data;
    } catch (e) {
      return <dynamic, dynamic>{};
    }
  }

  void UpdateProfile(Map<String, dynamic> data, String email) async {
    var docid = '';
    var doc = await database.updateDocument(
        databaseId: 'lingo',
        collectionId: 'profiles',
        documentId: docid,
        data: data);

    print(doc.data);
  }

  Future<ProfileModel?> GetProfile(String id) async {
    try {
      // print('in get profiles');
      // print(id);

      var documents = await database.listDocuments(
          databaseId: 'lingo',
          collectionId: 'profiles',
          queries: [Query.equal('email', id)]);

      ProfileModel model = ProfileModel();

      for (var document in documents.documents) {
        model = ProfileModel(
            name: document.data['name'].toString(),
            email: document.data['email'].toString(),
            id: document.$id,
            about: ProfilesApi.convertList(document.data['about']),
            dob: document.data['dob'].toString(),
            location: document.data['location'].toString(),
            pics: ProfilesApi.convertList(document.data['pics']),
            quotes: ProfilesApi.convertList(document.data['quotes']),
            profession: document.data['profession'].toString());

        // model.id = document.$id;
        // print(model.id);
        return model;
      }

      return null;

      // await Navigator.pushReplacementNamed(
      //     context, CreateAccountPage.routeName);
    } catch (e) {
      log(" Sign Up $e");
      return null;

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
}
