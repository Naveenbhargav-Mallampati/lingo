import 'package:flutter_riverpod/flutter_riverpod.dart';

final matchTabProvider = StateProvider<int>((ref) {
  print('changed');
  return 0;
});
