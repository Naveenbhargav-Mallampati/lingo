import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingo/Backend/accountApi.dart';
import 'package:lingo/controllers/AccountController.dart';

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  void createUser(WidgetRef ref, String email, String password,
      BuildContext context) async {
    ref.read(loading.notifier).state = true;

    final Authentication auth = ref.watch(authProvider);

    await auth.signUp(email, password, context).then((value) {
      ref.read(userLoggedInProvider.notifier).state = true;

      ref.read(loading.notifier).state = false;
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
            ),
            const QuoteText(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
            ),
            InkWell(
              onTap: () {
                createUser(ref, 'naveen@gmail.com', '1234567890', context);
              },
              child: Consumer(builder: (context, ref, child) {
                return ref.watch(loading) == true
                    ? const CircularProgressIndicator()
                    : const NextButton();
              }),
            )
          ],
        ),
      ),
    );
  }
}

class QuoteText extends StatelessWidget {
  const QuoteText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: const DecorationImage(
            fit: BoxFit.cover, image: AssetImage('assets/images/bg.png')),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Relations is not about swiping\nIt is about knowing\nAbout understanding\nAnd about Admiring..',
                textStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 200),
              ),
            ],
            totalRepeatCount: 1,
            pause: const Duration(milliseconds: 10),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
        ),
      ),
    );
  }
}

class NextButton extends ConsumerWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
        color: Colors.yellow[600],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          child: Text('Next',
              style: TextStyle(color: Colors.black, fontSize: 20.0)),
        ),
      ),
    );
  }
}
