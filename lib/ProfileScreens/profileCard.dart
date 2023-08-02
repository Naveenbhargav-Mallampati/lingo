import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingo/Backend/Homeapi.dart';
import 'package:lingo/ProfileScreens/ProfileViewScreens/profileBasicEdit.dart';
import 'package:lingo/ProfileScreens/ProfileViewScreens/profileedit.dart';
import 'package:lingo/ProfileScreens/profileTextedits.dart';
import 'package:lingo/controllers/AccountController.dart';
import 'package:lingo/general_screens/filters_screen.dart';
import 'package:lingo/onboarding/old/images_add.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../controllers/HomeController.dart';

// ignore: must_be_immutable
class ProfileCard extends ConsumerWidget {
  ScrollController controller;
  ProfileCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = ref.watch(ProfilesProvider(''));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lingo'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const FiltersScreen();
                },
              ));
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              child: Icon(
                Icons.tune,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: profiles.when(
          data: (data) {
            return CardSwiper(
              padding: const EdgeInsets.all(0.0),
              cardBuilder: (BuildContext context,
                  int index,
                  int horizontalOffsetPercentage,
                  int verticalOffsetPercentage) {
                return Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    child:
                        profilecard(false, ref, data[index], context, index));
              },
              numberOfCardsDisplayed: 3,
              cardsCount: data.length,
              backCardOffset: const Offset(0, 0),
            );
          },
          error: (error, stackTrace) {
            return Container(
              child: Text(error.toString()),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  static Widget profilecard(
    bool edit,
    WidgetRef ref,
    ProfileModel model,
    BuildContext context,
    int porofileindex,
  ) {
    String? fileid = "";
    List<Widget> allchilds = [];
    String? jwt = '';
    final storage = ref.read(StorageProvider);
    final client = ref.read(clientProvider);
    List<Widget> images = [];
    List<Widget> quotes = [];
    List<Widget> abouts = [];
    for (var element in model.pics!) {
      images.add(Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: CachedNetworkImage(
            // imageUrl: element.replaceAll(r'127.0.0.1', '10.0.2.2'),
            imageUrl:
                'https://10.0.2.2/v1/storage/buckets/profilepics/files/64b561f0b17a692bf9d2/view',
            httpHeaders: {
              'X-Appwrite-Project': client.config['project']!,
            },
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width - 40,
            fit: BoxFit.cover,
          ),
          // child: FutureBuilder(
          //   future: storage.getFilePreview(
          //     bucketId: 'profilepics',
          //     fileId: '64b561f0b17a692bf9d2',
          //   ), //works for both public file and private file, for private files you need to be logged in
          //   builder: (context, snapshot) {
          //     return snapshot.hasData && snapshot.data != null
          //         ? Image.memory(
          //             snapshot.data!,
          //           )
          //         : const CircularProgressIndicator();
          //   },
          // ),
        ),
      ));
    }
    for (var element in model.quotes!) {
      quotes.add(Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: Text(
            element,
            style: const TextStyle(color: Colors.black, fontSize: 16.0),
          ),
        ),
      ));
    }
    for (var element in model.about!) {
      abouts.add(Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: Text(
            element,
            style: const TextStyle(color: Colors.black, fontSize: 16.0),
          ),
        ),
      ));
    }
    int index = images.length >= quotes.length && images.length >= abouts.length
        ? images.length
        : quotes.length >= abouts.length && quotes.length >= images.length
            ? quotes.length
            : abouts.length;
    for (int i = 0; i < index; i++) {
      allchilds.add(const SizedBox(
        height: 30.0,
      ));
      if (images.length > i) {
        edit == true
            ? allchilds.add(InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return AddImages(
                      updation: true,
                    );
                  })));
                },
                child: images[i],
              ))
            : allchilds.add(images[i]);
        allchilds.add(const SizedBox(
          height: 10.0,
        ));
      }
      if (quotes.length > i) {
        edit == true
            ? allchilds.add(InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return ProfileTextsEdit(
                        secondaryIndex: 1,
                        index: index,
                        text: model.quotes![i]);
                  })));
                },
                child: quotes[i],
              ))
            : allchilds.add(quotes[i]);
        // allchilds.add(const SizedBox(
        //   height: 10.0,
        // ));
      }
      if (abouts.length > i) {
        edit == true
            ? allchilds.add(InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return ProfileTextsEdit(
                        secondaryIndex: 0, index: index, text: model.about![i]);
                  })));
                },
                child: abouts[i],
              ))
            : allchilds.add(abouts[i]);
      }
    }
    edit
        ? allchilds.add(
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return ProfileBasicEdit(
                      isedit: true,
                    );
                  })));
                },
                child: BasicCard(
                    name: model.name!,
                    dob: model.dob!,
                    profession: model.profession!,
                    gender: 'male',
                    distance: '20km Away',
                    location: model.location!)),
          )
        : allchilds.add(BasicCard(
            name: model.name!,
            dob: model.dob!,
            profession: model.profession!,
            gender: 'male',
            distance: '20km Away',
            location: model.location!));
    allchilds.add(const SizedBox(
      height: 70.0,
    ));

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            ref.watch(hide.state).state = false;
            return true;
          } else if (notification.direction == ScrollDirection.idle) {
            if (ref.watch(hide.state).state == false) {
              return false;
            } else {
              ref.watch(hide.state).state = true;
              return true;
            }
          } else {
            ref.watch(hide.state).state = true;
            return true;
          }
        },
        child: SingleChildScrollView(
          controller: ScrollController(keepScrollOffset: false),
          child: Column(
            children: allchilds,
          ),
        ),
      ),
    );
  }
}

class ImageView extends ConsumerWidget {
  const ImageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.asset(
          'assets/images/14.jpg',
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width - 40,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
