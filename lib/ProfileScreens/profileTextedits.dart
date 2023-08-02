import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingo/onboarding/ProfileCreation.dart';

// ignore: must_be_immutable
class ProfileTextsEdit extends ConsumerWidget {
  int index;
  String text;
  int secondaryIndex;
  ProfileTextsEdit(
      {super.key,
      required this.index,
      required this.text,
      required this.secondaryIndex});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: InputFields(
          text: text,
          secondaryIndex: secondaryIndex,
          readonly: false,
          index: index,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ProfileImageEdit extends ConsumerWidget {
  int index;
  ProfileImageEdit({super.key, required this.index});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(),
    );
  }
}
