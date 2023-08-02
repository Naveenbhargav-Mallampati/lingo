import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gender_picker/gender_picker.dart';
import 'package:lingo/controllers/profilecontroller.dart';
import 'package:lingo/onboarding/ProfileCreation.dart';
import 'package:lingo/onboarding/Start.dart';

class ProfileBasicEdit extends ConsumerWidget {
  bool isedit;
  String? date;
  String? gender;
  String? name;
  String? profession;
  ProfileBasicEdit({super.key, required this.isedit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 30.0,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: EditTextBasic(
                    hint: 'Name',
                    text: 'Some Guy Name',
                    callback: (String value) {
                      name = value;
                    },
                  )),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: EditTextBasic(
                    hint: 'Profession',
                    text: 'Software Engineer',
                    callback: (String value) {
                      profession = value;
                    },
                  )),
              const SizedBox(
                height: 30.0,
              ),
              GenderPickerWithImage(onChanged: ((value) {
                gender = value.toString();
              })),
              const SizedBox(
                height: 20.0,
              ),
              InkWell(
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime(1990),
                          firstDate: DateTime(1970),
                          lastDate: DateTime.now())
                      .then((value) {
                    date = value.toString();
                  });
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                  child: Text(
                    '20 years',
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ),
              ),
              InkWell(
                  onTap: () {}, child: Container(child: const NextButton())),
            ],
          ),
        ),
      ),
    );
  }

  void handleExit(BuildContext context, WidgetRef ref) {
    if (isedit) {
    } else {
      if (date != null) {
        ref.read(profileprovider).dob = date;
      }
      if (name != null) {
        ref.read(profileprovider).name = name;
      }
      if (profession != null) {
        ref.read(profileprovider).profession = profession;
      }
      // if (gender != null) {
      //  ref.read(profileprovider).gender = gender;
      // }

      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const ProfileCreation();
        },
      ));
    }
  }
}

// ignore: must_be_immutable
class EditTextBasic extends ConsumerWidget {
  String text;
  String hint;
  Function callback;
  EditTextBasic(
      {super.key,
      required this.hint,
      required this.text,
      required this.callback});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(color: Colors.white10, blurRadius: 5.0, spreadRadius: 3.0)
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(
            top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
        child: TextField(
          controller: TextEditingController(text: text),
          onChanged: ((value) {
            callback(value);
          }),
          cursorColor: Colors.black,
          keyboardType: TextInputType.multiline,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
