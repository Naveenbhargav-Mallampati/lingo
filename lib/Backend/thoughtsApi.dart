import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:riverpod/riverpod.dart';

class ThoughtsApi extends StateNotifier<List<ThoughtsModel>> {
  // final Client client;
  final Databases database;
  final String id;
  //ProfileModel state = ProfileModel();

  ThoughtsApi(this.database, this.id) : super([]) {
    // database = Databases(client);
    GetProfile(id);
  }

  void GetProfile(String id) async {
    try {
      // print('in get profiles');
      // print(id);
      var documents = await database.listDocuments(
        databaseId: 'lingo',
        collectionId: 'thoughts',
        // queries: [Query.equal('email', id)]
      );
      print(documents.total);
      print(documents.documents.last.data);

      for (var document in documents.documents) {
        print("in loop");
        ThoughtsModel model = ThoughtsModel(
          id: document.$id,
        );
        if (document.data.containsKey('thought')) {
          model.thought = document.data['thought'];
        }

        if (document.data.containsKey('image')) {
          model.thought_img = document.data['image'];
        }

        // model.id = document.$id;
        // print(model.id);
        state = [...state, model];
      }

      // await Navigator.pushReplacementNamed(
      //     context, CreateAccountPage.routeName);
    } catch (e) {
      log(" Sign Up $e");

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

  Future<String>? sendThought(String thought) async {
    String? id;
    try {
      final doc = await database.createDocument(
          databaseId: 'lingo',
          collectionId: 'thoughts',
          documentId: ID.unique(),
          data: {'thought': thought});

      id = doc.$id;
      return id;
    } on AppwriteException catch (e) {
      log(e.toString());
      return '';
    }
  }
}

class ThoughtsModel {
  String? thought;
  String? thought_img;
  String? id;

  ThoughtsModel({this.thought, this.id, this.thought_img});

  ThoughtsModel copy({String? thought, String? thought_img, String? id}) =>
      ThoughtsModel(
          thought: this.thought, id: this.id, thought_img: this.thought_img);
}
