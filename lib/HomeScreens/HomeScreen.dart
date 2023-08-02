import 'package:flutter/material.dart';
import 'package:lingo/ProfileScreens/ProfileMatch.dart';
import 'package:lingo/ProfileScreens/ProfileViewScreens/Profilehome.dart';
import 'package:lingo/controllers/HomeController.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingo/HomeScreens/thoughts/thoughtsHome.dart';
import 'package:lingo/ProfileScreens/profileCard.dart';
import 'package:lingo/controllers/AccountController.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(clientProvider);
    return const Scaffold(
      body: MyHome(),
    );
  }
}

class MyHome extends ConsumerStatefulWidget {
  const MyHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return MyHomeState();
  }
}

class MyHomeState extends ConsumerState<MyHome> {
  List<SalomonBottomBarItem> icons = [
    SalomonBottomBarItem(
        icon: const Icon(Icons.home_outlined),
        title: const Text('Home'),
        selectedColor: Colors.yellow),
    SalomonBottomBarItem(
        icon: const Icon(Icons.bubble_chart_outlined),
        title: const Text('FunZone'),
        selectedColor: Colors.yellow),
    SalomonBottomBarItem(
        icon: const Icon(Icons.feed_outlined),
        title: const Text('Thoughts'),
        selectedColor: Colors.yellow),
    SalomonBottomBarItem(
        icon: const Icon(Icons.heart_broken_outlined),
        title: const Text('Connect'),
        selectedColor: Colors.yellow),
    SalomonBottomBarItem(
        icon: const Icon(Icons.person_outlined),
        title: const Text('Profile'),
        selectedColor: Colors.yellow),
  ];
  int index = 0;

  @override
  void initState() {
    print('init state');

    print('after init');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: index == 0
            ? ProfileCard(controller: ScrollController())
            : index == 1
                ? Container()
                : index == 2
                    ? Thoughts_Screen(controller: ScrollController())
                    : index == 3
                        ? ProfileMatch(controller: ScrollController())
                        : const ProfileHome(),
      ),
      bottomNavigationBar: Visibility(
          maintainAnimation: true,
          maintainState: true,
          visible: !ref.watch(hide.state).state,
          child: SalomonBottomBar(
              currentIndex: index,
              onTap: (p0) {
                setState(() {
                  index = p0;
                });
              },
              items: icons)),
    );
  }
}

// class BottomNavBar extends ConsumerStatefulWidget {
//   const BottomNavBar({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() {
//     return BottomNavBarState();
//   }
// }

// class BottomNavBarState extends ConsumerState<BottomNavBar>
//     with SingleTickerProviderStateMixin {
//   ScrollController controller = ScrollController();
//   late int currentPage;
//   late TabController tabController;
//   final List<Color> colors = [
//     Colors.yellow,
//     Colors.yellow,
//     Colors.yellow,
//     Colors.yellow,
//     Colors.yellow
//   ];

//   @override
//   void initState() {
//     currentPage = 0;
//     tabController = TabController(length: 5, vsync: this);
//     tabController.animation!.addListener(
//       () {
//         final value = tabController.animation!.value.round();
//         if (value != currentPage && mounted) {
//           changePage(value);
//         }
//       },
//     );
//     ProfilesApi(ref.read(databaseProvider)).GetProfiles();
//     super.initState();
//   }

//   void changePage(int newPage) {
//     setState(() {
//       currentPage = newPage;
//     });
//   }

//   @override
//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }

//   var currentpage = 0;

//   void _handleIndexChanged(int i) {
//     setState(() {
//       currentpage = i;
//     });
//   }

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     final Color unselectedColor = colors[currentPage].computeLuminance() < 0.5
//         ? Colors.white
//         : Colors.white;
//     return Scaffold(
//       body: BottomBar(
//         fit: StackFit.expand,
//         borderRadius: BorderRadius.circular(500),
//         duration: const Duration(seconds: 1),
//         curve: Curves.decelerate,
//         showIcon: true,
//         width: MediaQuery.of(context).size.width * 0.8,
//         barColor: colors[currentPage].computeLuminance() > 0.5
//             ? Colors.black
//             : Colors.black,
//         start: 2,
//         end: 0,
//         bottom: 10,
//         alignment: Alignment.bottomCenter,
//         iconHeight: 35,
//         iconWidth: 35,
//         reverse: false,
//         hideOnScroll: true,
//         scrollOpposite: false,
//         onBottomBarHidden: () {},
//         onBottomBarShown: () {},
//         body: ((context, controller) {
//           return currentPage == 0
//               ? ProfileCard(controller: controller)
//               : currentPage == 1
//                   ? Container()
//                   : currentPage == 2
//                       ? Thoughts_Screen(controller: controller)
//                       : currentPage == 3
//                           ? ProfileMatch(controller: controller)
//                           : const ProfileHome();
//         }),
//         child: TabBar(
//           indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
//           controller: tabController,
//           indicator: UnderlineTabIndicator(
//               borderSide: BorderSide(
//                   color: currentPage == 0
//                       ? colors[0]
//                       : currentPage == 1
//                           ? colors[1]
//                           : currentPage == 2
//                               ? colors[2]
//                               : currentPage == 3
//                                   ? colors[3]
//                                   : currentPage == 4
//                                       ? colors[4]
//                                       : unselectedColor,
//                   width: 4),
//               insets: const EdgeInsets.fromLTRB(16, 0, 16, 8)),
//           tabs: [
//             SizedBox(
//               height: 55,
//               width: 40,
//               child: Center(
//                   child: Icon(
//                 Icons.home,
//                 color: currentPage == 0 ? colors[0] : unselectedColor,
//               )),
//             ),
//             SizedBox(
//               height: 55,
//               width: 40,
//               child: Center(
//                   child: Icon(
//                 Icons.search,
//                 color: currentPage == 1 ? colors[1] : unselectedColor,
//               )),
//             ),
//             SizedBox(
//               height: 55,
//               width: 40,
//               child: Center(
//                   child: Icon(
//                 Icons.add,
//                 color: currentPage == 2 ? colors[2] : unselectedColor,
//               )),
//             ),
//             SizedBox(
//               height: 55,
//               width: 40,
//               child: Center(
//                   child: Icon(
//                 Icons.favorite,
//                 color: currentPage == 3 ? colors[3] : unselectedColor,
//               )),
//             ),
//             SizedBox(
//               height: 55,
//               width: 40,
//               child: Center(
//                   child: Icon(
//                 Icons.settings,
//                 color: currentPage == 4 ? colors[4] : unselectedColor,
//               )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
