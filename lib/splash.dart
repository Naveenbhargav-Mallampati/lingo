import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Splash extends ConsumerWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 30.0, top: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width - 60,
                    child: Image.asset(
                      'assets/images/splashimg.png',
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width - 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 4 - 50,
                    left: MediaQuery.of(context).size.width / 4 + 30,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4 - 100,
                      width: MediaQuery.of(context).size.width / 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        // image: const DecorationImage(
                        //     scale: 3.0,
                        //     fit: BoxFit.cover,
                        //     image: AssetImage('assets/images/splashimg.png')),
                      ),
                      child: Image.asset(
                        'assets/images/splashlogo.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/bg.png')),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Be Little Strange!',
                          textStyle: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.normal,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
