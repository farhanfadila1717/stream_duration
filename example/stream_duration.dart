import 'package:stream_duration/stream_duration.dart';

void main() {
  /// Countdown
  var streamDuration = StreamDuration(Duration(seconds: 10), onDone: () {
    print('Stream Done 👍');
  });

  streamDuration.durationLeft.listen((event) {
    print(event.inSeconds);
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
