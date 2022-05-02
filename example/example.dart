import 'package:stream_duration/stream_duration.dart';

void main() {
  var addOnce = false;

  /// Countdown
  var streamDuration = StreamDuration(
    const Duration(minutes: 2),
    onDone: () {
      print('Stream Done 👍');
    },
  );

  streamDuration.durationLeft.listen((duration) {
    print('Duration left in seconds ${duration.inSeconds}');
    if (duration.inSeconds == 115) {
      print('correct');
      streamDuration.correct(const Duration(seconds: 5));
    } else if (duration.inSeconds == 100 && !addOnce) {
      print('Add');
      streamDuration.add(const Duration(seconds: 5));
      addOnce = true;
    } else if (duration.inSeconds == 90) {
      print('Subtract');
      streamDuration.subtract(const Duration(seconds: 5));
    }
  });

  /// Countup
  var streamDurationUp = StreamDuration(Duration(seconds: 10), onDone: () {
    print('Stream Done 👍');
  }, countUp: true);

  streamDurationUp.durationLeft.listen((event) {
    print(event.inSeconds);
  });

  /// Countup Infinity
  var streamDurationUpInfinity =
      StreamDuration(Duration(seconds: 10), countUp: true, infinity: true);

  streamDurationUpInfinity.durationLeft.listen((event) {
    print(event.inSeconds);
  });
}
