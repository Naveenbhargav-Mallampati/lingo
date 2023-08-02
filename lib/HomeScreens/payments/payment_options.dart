import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatymentsOptions extends ConsumerWidget {
  const PatymentsOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        child: PageView(
          children: [
            paymentCard(price: '399', time: '\t\tper month', features: const [
              'Unlimited chat with requests',
              '30 spotlights for you',
              '10 backtrack to correct',
              'participation in contests'
            ]),
            paymentCard(
                price: '999',
                time: '\t\tper 3 months',
                features: const [
                  'Unlimited chat with requests',
                  '30 spotlights for you',
                  '10 backtrack to correct'
                ]),
            paymentCard(price: '2999', time: '\t\tper year', features: const [
              'Unlimited chat with requests',
              '30 spotlights for you',
              '10 backtrack to correct '
            ]),
            paymentCard(price: '14999', time: '\t\tlife time', features: const [
              'Unlimited chat with requests',
              '30 spotlights for you',
              '10 backtrack to correct'
            ]),
          ],
        ),
      ),
    );
  }
}

class paymentCard extends ConsumerWidget {
  String price;
  String time;
  List<String> features;
  paymentCard(
      {super.key,
      required this.price,
      required this.time,
      required this.features});

  List<Widget> makeFeatures() {
    List<Widget> widgets = [];
    for (var element in features) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            element,
            style: const TextStyle(fontSize: 24.0, color: Colors.black54),
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
      width: MediaQuery.of(context).size.width,
      color: Colors.yellow[100],
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  price,
                  style: const TextStyle(fontSize: 40.0, color: Colors.black),
                ),
                Text(
                  time,
                  style: const TextStyle(fontSize: 20.0, color: Colors.black54),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 8,
                right: MediaQuery.of(context).size.width / 8),
            child: const Divider(),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: makeFeatures(),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(20.0)),
              margin: const EdgeInsets.only(top: 20.0),
              width: MediaQuery.of(context).size.width - 60,
              child: const Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                  child: Text(
                    'Get Started',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
