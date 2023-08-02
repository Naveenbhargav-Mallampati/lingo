import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingo/HomeScreens/chatscreens/chatarea.dart';
import 'package:lingo/ProfileScreens/widgets/profileMatchWidgets.dart';
import 'package:lingo/controllers/MatchesController.dart';

// ignore: must_be_immutable
class ProfileMatch extends ConsumerWidget {
  ScrollController controller;
  ProfileMatch({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchtab = ref.watch(matchTabProvider);
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              const SizedBox(
                height: 30.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        ref.read(matchTabProvider.notifier).state = 0;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: matchtab == 0 ? Colors.yellow : Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 40.0),
                          child: Text('Chats'),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ref.read(matchTabProvider.notifier).state = 1;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: matchtab == 1 ? Colors.yellow : Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 40.0),
                          child: Text('Matches'),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ref.read(matchTabProvider.notifier).state = 2;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: matchtab == 2 ? Colors.yellow : Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text('Connections'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              matchtab == 0
                  ? ChatTab(count: 10, controller: controller)
                  : matchtab == 1
                      ? const matchTab()
                      : const matchTab()
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ChatTab extends ConsumerWidget {
  int count;
  ScrollController controller;

  ChatTab({super.key, required this.count, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        child: ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      //controller: controller,
      itemCount: count,
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ChatArea();
              },
            ));
          },
          child: Mtile(
              name: 'Someone',
              pic: 'assets/images/14.jpg',
              last: 'Thats interesting to know..'),
        );
      }),
    ));
  }
}

class matchTab extends ConsumerWidget {
  const matchTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 30.0,
          ),
          const Text(
            'Requests',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return Profile_card_element(
                      name: 'SomeHero', age: '26', profession: 'Actor/Actress');
                })),
          ),
          const SizedBox(
            height: 30.0,
          ),
          const Text(
            'Suggestions',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return Profile_card_element(
                      name: 'SomeHero', age: '26', profession: 'Actor/Actress');
                })),
          ),
          const SizedBox(
            height: 30.0,
          ),
          const Text(
            'Pending Proposals',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return Profile_card_element(
                      name: 'SomeHero', age: '26', profession: 'Actor/Actress');
                })),
          ),
        ],
      ),
    );
  }
}
