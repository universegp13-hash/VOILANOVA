import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dealCountdownProvider =
    StateNotifierProvider<CountdownNotifier, Duration>((ref) {
  return CountdownNotifier();
});

class CountdownNotifier extends StateNotifier<Duration> {
  Timer? _timer;

  CountdownNotifier()
      : super(const Duration(hours: 5, minutes: 32, seconds: 12)) {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.inSeconds > 0) {
        state = state - const Duration(seconds: 1);
      } else {
        state = const Duration(hours: 23, minutes: 59, seconds: 59);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
