import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingo/HomeScreens/thoughts/ThoughtsCreation.dart';
import 'package:lingo/controllers/thoughtsController.dart';

class Thoughts_Screen extends ConsumerStatefulWidget {
  ScrollController controller;
  Thoughts_Screen({super.key, required this.controller});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return Thoughts_Screen_state(controller: controller);
  }
}

class Thoughts_Screen_state extends ConsumerState<Thoughts_Screen>
    with WidgetsBindingObserver {
  //AppWrite_Backend_Communication backend;
  ScrollController controller;
  Thoughts_Screen_state({required this.controller});

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    if (state == AppLifecycleState.resumed) {
      print('in resume');
      ref.read(ThoughtApiProvider).GetProfile('');
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final thoughtsprovider = ref.watch(ThoughtssProvider(""));

    return Scaffold(
        floatingActionButton: InkWell(
          onTap: (() {
            Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
              return Thought_text(hint: '');
            })));
          }),
          child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.black),
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
        ),
        body: thoughtsprovider.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    controller: controller,
                    itemCount: thoughtsprovider.length,
                    itemBuilder: ((context, index) {
                      return Thought_Card(
                        id: thoughtsprovider[index].id!,
                        thought: thoughtsprovider[index].thought,
                        url_img: thoughtsprovider[index].thought_img,
                      );
                    }))));
  }
}

class Thought_Card extends StatelessWidget {
  String? thought;
  String id;
  String? url_img;
  Thought_Card({super.key, this.thought, required this.id, this.url_img});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   margin: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 20.0),
          //   child: Text(
          //     texts[0],
          //     style: const TextStyle(color: Colors.black, fontSize: 16.0),
          //   ),
          // ),
          url_img == null
              ? const SizedBox(
                  height: 10.0,
                )
              : Container(
                  margin: const EdgeInsets.only(left: 10.0, bottom: 20.0),
                  child: Image.network(
                    url_img!,
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width - 40,
                    fit: BoxFit.cover,
                  ),
                ),

          thought == null
              ? const SizedBox(
                  height: 10.0,
                )
              : Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 40.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: Text(
                      thought!,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                  ),
                ),
          // Container(
          //   margin: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 20.0),
          //   child: Row(
          //     children: [
          //       Container(
          //         margin: const EdgeInsets.only(right: 20.0),
          //         child: IconButton(
          //             onPressed: () {},
          //             icon: const Icon(
          //               Icons.favorite,
          //               size: 30.0,
          //               color: Colors.black,
          //             )),
          //       ),
          //       Container(
          //         margin: const EdgeInsets.only(right: 20.0),
          //         child: IconButton(
          //             onPressed: () {},
          //             icon: const Icon(
          //               Icons.waving_hand,
          //               size: 30.0,
          //               color: Colors.black,
          //             )),
          //       ),
          //       IconButton(
          //           onPressed: () {},
          //           icon: const Icon(
          //             Icons.chat,
          //             size: 30.0,
          //             color: Colors.black,
          //           ))
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
