import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingo/controllers/AccountController.dart';
import 'package:lingo/controllers/profilecontroller.dart';
import 'package:lingo/onboarding/Start.dart';

class ProfileCreation extends ConsumerWidget {
  const ProfileCreation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      //backgroundColor: Colors.grey[500],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            InputFields(
              index: 0,
              text: 'Tell us about you...',
              readonly: false,
              secondaryIndex: 0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            InputFields(
              index: 0,
              text: 'A little Quote Here...',
              readonly: false,
              secondaryIndex: 1,
            ),
            const SizedBox(
              height: 10.0,
            ),
            InputFields(
              index: 1,
              text: 'Tell us about you...',
              readonly: false,
              secondaryIndex: 0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            InputFields(
              index: 1,
              text: 'A little Quote Here...,',
              readonly: false,
              secondaryIndex: 1,
            ),
            const SizedBox(
              height: 40.0,
            ),
            InkWell(onTap: () {}, child: Container(child: const NextButton())),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  void sendData(WidgetRef ref) {
    ref.watch(userProvider).whenData((value) {
      ref.read(profileprovider).id = value!.$id;
      var model = ref.watch(SetuserProfileProvider(ref.read(profileprovider)));
      model.whenData((value) {
        print(value);
      });
    });
  }
}

// ignore: must_be_immutable
class InputFields extends ConsumerWidget {
  String text;
  bool readonly;
  int index;
  int secondaryIndex;
  InputFields(
      {super.key,
      required this.text,
      required this.readonly,
      required this.index,
      required this.secondaryIndex});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileProvider = ref.watch(profileprovider.state).state;
    return Container(
      margin: const EdgeInsets.only(
          top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 20.0),
          //   child: Text(
          //     text,
          //     style: const TextStyle(color: Colors.black, fontSize: 16.0),
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.white10, blurRadius: 5.0, spreadRadius: 3.0)
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
              child: TextField(
                controller: TextEditingController(),
                onChanged: ((value) {
                  if (secondaryIndex == 0) {
                    if (profileProvider.about!.elementAtOrNull(index) != null) {
                      ref.read(profileprovider).about![index] = value;
                    } else {
                      ref.read(profileprovider).about!.add(value);
                    }
                  } else {
                    if (profileProvider.quotes!.elementAtOrNull(index) !=
                        null) {
                      ref.read(profileprovider).quotes![index] = value;
                    } else {
                      ref.read(profileprovider).quotes!.add(value);
                    }
                  }
                }),
                cursorColor: Colors.black,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                showCursor: true,
                readOnly: readonly,
                decoration: InputDecoration(
                  hintText: text,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
