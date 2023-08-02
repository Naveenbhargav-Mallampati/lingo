import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingo/HomeScreens/payments/payment_options.dart';
import 'package:lingo/ProfileScreens/ProfileViewScreens/profileedit.dart';
import 'package:lingo/general_screens/settings.dart';

class ProfileHome extends ConsumerWidget {
  const ProfileHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [const ProfileChip(), profile_options(), PaymentArea()],
          ),
        ),
      ),
    );
  }
}

class ProfileChip extends ConsumerWidget {
  const ProfileChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return const ProfileEdit();
                  })));
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      right: 20.0, left: 20.0, top: 20.0, bottom: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.asset(
                      'assets/images/14.jpg',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(top: 30.0),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        'Someguy Here',
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                      ),
                    ),
                    Text(
                      'Software engineer',
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              // IconButton(
              //     onPressed: () {
              //       Get.to(ProfileEdit());
              //     },
              //     icon: Icon(
              //       Ionicons.create_outline,
              //       size: 40.0,
              //     ))

              const SizedBox(
                width: 70.0,
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(
                  top: 40.0,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const SettingsPage();
                      },
                    ));
                  },
                  child: const Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: 30.0,
                  ),
                ),
              ),
            ],
          ),
          // Container(
          //   margin: EdgeInsets.only(bottom: 10.0),
          //   child: Row(
          //     children: [
          //       InkWell(
          //           onTap: () {
          //             Get.to(Request());
          //           },
          //           child: ProfileRow(number: mstrs[0][0], title: mstrs[0][1])),
          //       InkWell(
          //           onTap: () {
          //             Get.to(Request());
          //           },
          //           child: ProfileRow(number: mstrs[1][0], title: mstrs[1][1])),
          //       InkWell(
          //           onTap: () {
          //             Get.to(Request());
          //           },
          //           child: ProfileRow(number: mstrs[2][0], title: mstrs[2][1])),
          //     ],
          //   ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class profile_options extends StatelessWidget {
  List<List<String>> texts = [
    ["superSwipes", "5/10"],
    ["Spot Light", "5/10"],
    ["Suggestions", "5/10"]
  ];
  List<Color> mcolors = [Colors.blue, Colors.yellow, Colors.cyan];

  profile_options({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30.0, left: 20.0),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: texts.length,
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            return InkWell(
              onTap: (() {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const PatymentsOptions();
                  },
                ));
              }),
              child: Container(
                width: (MediaQuery.of(context).size.width) - 40,
                margin: const EdgeInsets.only(
                    left: 5.0, right: 20.0, top: 10.0, bottom: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    //color: Gradient.linear(from, to, colors),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [mcolors[index], Colors.white],
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          texts[index][0],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          texts[index][1],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          })),
    );
  }
}

// ignore: must_be_immutable
class PaymentArea extends StatelessWidget {
  PaymentArea({Key? key}) : super(key: key);

  List<String> titles = ["Premium", "Exciting options specially for you"];

  List<Widget> texts = [];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const PatymentsOptions();
          },
        ));
      }),
      child: Container(
        width: MediaQuery.of(context).size.width - 10,
        margin: const EdgeInsets.only(top: 30.0, left: 0.0, right: 0.0),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 20.0, bottom: 20.0, left: 0.0, right: 30.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      titles[0],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 20,
                        height: 40.0,
                        child: Text(
                          titles[1],
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
