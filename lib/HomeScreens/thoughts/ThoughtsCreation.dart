import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_editor_dove/image_editor.dart';
import 'package:lingo/controllers/thoughtsController.dart';
import 'package:path_provider/path_provider.dart';

class Thoughts_options extends ConsumerWidget {
  const Thoughts_options({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) {
                  return Thought_text(
                    hint: 'Tell your thought Here..',
                  );
                })));
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    top: MediaQuery.of(context).size.height / 4,
                    bottom: 30.0),
                decoration: const BoxDecoration(),
                child: Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                    color: Colors.yellow[600],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30.0),
                      child: Text('Thought Message',
                          style:
                              TextStyle(color: Colors.black, fontSize: 20.0)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) {
                  return const Thoughts_Photo_pic();
                })));
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10.0),
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                    child: Text('Thought Image',
                        style: TextStyle(color: Colors.black, fontSize: 20.0)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Thoughts_Photo_pic extends ConsumerWidget {
  const Thoughts_Photo_pic({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> toImageEditor(File origin) async {
      // return Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return ImageEditor(
      //     originImage: origin,
      //     //this is nullable, you can custom new file's save postion
      //   );
      // })).then((result) {
      //   if (result is EditorImageResult) {
      //     print('got result');
      //     print(result.imgHeight);
      //   }
      // }).catchError((er) {
      //   debugPrint(er);
      // });
    }

    return Scaffold(
      body: GridView.builder(
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: ((context, index) {
            return InkWell(
              onTap: () {
                getImageFileFromAssets('placeholders/${index + 1}.jpg')
                    .then((value) {
                  toImageEditor(value);
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Image.asset(
                  'assets/placeholders/${index + 1}.jpg',
                  height: MediaQuery.of(context).size.height / 4,
                  width: ((MediaQuery.of(context).size.width - 40) / 2),
                ),
              ),
            );
          })),
    );
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}

class Thought_text extends ConsumerWidget {
  String hint;
  Thought_text({super.key, required this.hint});
  TextEditingController con = TextEditingController();

  void sendthought(WidgetRef ref, String thought, BuildContext context) async {
    ref.read(thoughttap.notifier).state = true;
    final out = ref.watch(thoughtcreated.call(thought).future);
    out.then((value) {
      print(value);
      ref.watch(thoughtSendStatus.notifier).state = true;
      ref.read(thoughttap.notifier).state = false;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              margin: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: MediaQuery.of(context).size.height / 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.white54, blurRadius: 4.0, spreadRadius: 2.0)
                ],
              ),
              child: TextField(
                controller: con,
                onChanged: ((value) {}),
                cursorColor: Colors.black,
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: '\t\t Express yourself here...',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            InkWell(
              onTap: () {
                sendthought(ref, con.text, context);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10.0),
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 30.0),
                    child: ref.read(thoughttap.notifier).state == false
                        ? const Text('Done',
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0))
                        : const CircularProgressIndicator(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
