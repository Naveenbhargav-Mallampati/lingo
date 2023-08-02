import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker_widget/image_picker_widget.dart';
import 'package:lingo/Backend/accountApi.dart';
import 'package:lingo/HomeScreens/HomeScreen.dart';
import 'package:lingo/controllers/AccountController.dart';
import 'package:lingo/controllers/profilecontroller.dart';
import 'package:lingo/onboarding/Start.dart';
import 'package:appwrite/src/input_file.dart';

class AddImages extends ConsumerWidget {
  bool updation;
  AddImages({super.key, required this.updation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileModel = ref.watch(profileprovider.state).state;
    final storage = ref.read(StorageProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ImageInput(
                    calback: (File myfile) {
                      InputFile mynew = InputFile.fromPath(path: myfile.path);
                      ApiService.uploadFile('profilepics', mynew, storage)
                          .then((value) {
                        if (value.name.isNotEmpty) {
                          return;
                        }
                        if (profileModel.pics!.isNotEmpty) {
                          ref.read(profileprovider).pics![0] = value.$id;
                        } else {
                          ref.read(profileprovider).pics!.add(value.$id);
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    width: 30.0,
                  ),
                  ImageInput(
                    calback: (File myfile) {
                      InputFile mynew = InputFile.fromPath(path: myfile.path);
                      ApiService.uploadFile('profilepics', mynew, storage)
                          .then((value) {
                        if (value.name.isNotEmpty) {
                          return;
                        }
                        if (profileModel.pics!.length > 1) {
                          ref.read(profileprovider).pics![1] = value.$id;
                        } else {
                          ref.read(profileprovider).pics!.add(value.$id);
                        }
                      });
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ImageInput(
                    calback: (File myfile) {
                      InputFile mynew = InputFile.fromPath(path: myfile.path);
                      ApiService.uploadFile('profilepics', mynew, storage)
                          .then((value) {
                        if (value.name.isNotEmpty) {
                          return;
                        }
                        if (profileModel.pics!.length > 2) {
                          ref.read(profileprovider).pics![2] = value.$id;
                        } else {
                          ref.read(profileprovider).pics!.add(value.$id);
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    width: 30.0,
                  ),
                  ImageInput(
                    calback: (File myfile) {
                      InputFile mynew = InputFile.fromPath(path: myfile.path);
                      ApiService.uploadFile('profilepics', mynew, storage)
                          .then((value) {
                        if (value.name.isNotEmpty) {
                          return;
                        }
                        if (profileModel.pics!.length > 3) {
                          ref.read(profileprovider).pics![3] = value.$id;
                        } else {
                          ref.read(profileprovider).pics!.add(value.$id);
                        }
                      });
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const HomeScreen();
                    },
                  ));
                },
                child: const NextButton())
          ],
        ),
      ),
    );
  }
}

class ImageInput extends ConsumerWidget {
  String? url;
  Function? calback;
  ImageInput({
    super.key,
    this.url,
    this.calback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: ImagePickerWidget(
        editIcon: Container(
          margin: const EdgeInsets.all(10.0),
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
        diameter: 150,
        initialImage: url == null
            ? const AssetImage("assets/images/2.jpg")
            : Image.network(url!),
        borderRadius: const Radius.circular(20.0),
        shape: ImagePickerWidgetShape.square, // ImagePickerWidgetShape.square
        isEditable: true,
        onChange: (p0) {
          if (calback != null) {
            print('in change');
            calback!(p0);
          }
        },
      ),
    );
  }
}
