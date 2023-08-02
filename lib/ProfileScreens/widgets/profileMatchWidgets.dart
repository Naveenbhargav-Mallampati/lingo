import 'package:flutter/material.dart';

//chat Widgets

// ignore: must_be_immutable
class Mtile extends StatelessWidget {
  String? name;
  String? pic;
  String? last;
  Mtile({Key? key, required this.name, required this.pic, required this.last})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          child: ListTile(
            leading: ProfileClips(name: pic!),
            title: Text(
              name!,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              last!,
              style: TextStyle(
                  fontSize: 14.0,
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: const Divider(
            color: Colors.grey,
            thickness: 1.0,
          ),
        ),
      ],
    );
  }
}

// Match tab Widgets

// ignore: must_be_immutable
class ProfileClips extends StatelessWidget {
  String name;
  ProfileClips({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: InkWell(
        onTap: (() {}),
        child: ClipRRect(
          // borderRadius: BorderRadius.only(
          //     topLeft: Radius.elliptical(20, 20),
          //     topRight: Radius.elliptical(10, 10),
          //     bottomLeft: Radius.elliptical(10, 10),
          //     bottomRight: Radius.elliptical(90, 40)),
          borderRadius: BorderRadius.circular(20.0),
          child: Image(
            image: AssetImage(name),
            height: 150.0,
            width: 60.0,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class ProfilfeChips_large extends StatelessWidget {
  String name;
  double height;
  double width;
  ProfilfeChips_large(
      {super.key,
      required this.name,
      required this.height,
      required this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: InkWell(
        onTap: (() {}),
        child: ClipRRect(
          // borderRadius: BorderRadius.only(
          //     topLeft: Radius.elliptical(20, 20),
          //     topRight: Radius.elliptical(10, 10),
          //     bottomLeft: Radius.elliptical(10, 10),
          //     bottomRight: Radius.elliptical(90, 40)),
          borderRadius: BorderRadius.circular(20.0),
          child: Image(
            image: AssetImage(name),
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class Profile_card_element extends StatelessWidget {
  String name, age, profession;
  Profile_card_element(
      {super.key,
      required this.name,
      required this.age,
      required this.profession});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width - 40,
      margin: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 30.0, bottom: 10.0),
      decoration: BoxDecoration(
        image: const DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              "assets/images/2.jpg",
            )),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20.0),
            )),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(color: Colors.black, fontSize: 20.0),
              ),
              Text(
                "$profession , $age",
                style: const TextStyle(color: Colors.black, fontSize: 20.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
