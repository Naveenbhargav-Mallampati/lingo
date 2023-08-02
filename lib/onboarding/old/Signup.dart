import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingo/onboarding/Start.dart';

class Signup extends ConsumerWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
          ),
          Container(
            margin: const EdgeInsets.only(
                top: 20.0, bottom: 40.0, left: 10.0, right: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.white10, blurRadius: 5.0, spreadRadius: 3.0)
              ],
            ),
            child: Container(
              margin: const EdgeInsets.only(
                  top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
              child: My_TextEdit_View(
                hint: "Email:",
                index: 0,
                border: false,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                top: 20.0, bottom: 40.0, left: 10.0, right: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.white10, blurRadius: 5.0, spreadRadius: 3.0)
              ],
            ),
            child: Container(
              margin: const EdgeInsets.only(
                  top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
              child: My_TextEdit_View(
                hint: "Name:",
                index: 2,
                border: false,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                top: 20.0, bottom: 40.0, left: 10.0, right: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.white10, blurRadius: 5.0, spreadRadius: 3.0)
              ],
            ),
            child: Container(
              margin: const EdgeInsets.only(
                  top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
              child: My_TextEdit_View(
                hint: "Password:",
                index: 1,
                border: false,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: const NextButton(),
          ),
        ]),
      ),
    );
  }
}

class My_TextEdit_View extends StatelessWidget {
  String? hint;
  //dynamic controller;
  int? index;
  bool? border;

  My_TextEdit_View({Key? key, this.hint, this.index, this.border})
      : super(key: key);

  TextEditingController mcon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: border!
            ? TextField(
                controller: mcon,
                onChanged: (value) {},
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(),
                  hintText: hint,
                  hintStyle: const TextStyle(color: Colors.black),
                ),
              )
            : TextField(
                controller: mcon,
                onChanged: (value) {},
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: hint,
                  hintStyle: const TextStyle(color: Colors.black),
                ),
              ));
  }
}
