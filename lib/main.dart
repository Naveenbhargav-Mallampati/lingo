import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingo/AppLocal/themes.dart';
import 'package:lingo/HomeScreens/HomeScreen.dart';
import 'package:lingo/onboarding/Start.dart';
import 'package:lingo/onboarding/login_page.dart';
import 'package:lingo/onboarding/old/images_add.dart';

import 'controllers/AccountController.dart';

import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  //  to ensure widgets are glued properly
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  //  provider scope is nessary to access the all the providers
  runApp(const ProviderScope(child: MainApp()));
}

//  I used a stateful widget so that I can use the initState method
//  to check if the user is logged in or not
//  and then decide the course of action
class MainApp extends ConsumerStatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  Future<void> _init(WidgetRef ref) async {
    //  This is how you can access providers in stateful widgets
    final user = await ref.read(authProvider).getAccount();
    if (user != null) {
      //  This is how you can modify the state of the providers
      ref.read(userLoggedInProvider.notifier).state = true;
    } else {
      ref.read(userLoggedInProvider.notifier).state = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _init(ref);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'No Signal',
      themeMode: ref.read(themesProvider),
      darkTheme: Themes.darkTheme,
      theme: Themes.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const AuthChecker(),
      // routes: {
      //   LoginPage.routename: (context) => const LoginPage(),
      //   HomePage.routename: (context) => const HomePage(),
      //   CreateAccountPage.routeName: (context) => const CreateAccountPage(),
      //   ChatPage.routeName: (context) => ChatPage(),
      //   UsersListPage.routeName: (context) => const UsersListPage(),
      //   SettingsScreen.routename: (context) => const SettingsScreen(),
      // },
    );
  }
}

//   This is authchecker widget which is used to check if the user is logged in or not
//  since it depends on state we do not need to use navigator to route to widgets
//  it will automatically change acc to the state
class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

//  So here's the thing what we have done
//  if the _isLoggedIn is true, we will go to Home Page
//  if false we will go to Welcome Page
// and if the user is null we will show a Loading screen
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(userLoggedInProvider.state).state;
    if (isLoggedIn == true) {
      return const HomeScreen(); // It's asimple basic screen showing the home page with welcome message
    } else if (isLoggedIn == false) {
      return const LoginPage();
    }
    return const StartScreen(); // It's a plain screen with a circular progress indicator in Center
  }
}
