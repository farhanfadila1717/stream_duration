import 'package:stream_duration/stream_duration.dart';

void main() {
  /// Countdown
  var streamDuration = StreamDuration(Duration(seconds: 10), onDone: () {
    print('Stream Done');
  });

  streamDuration.durationLeft.listen((event) {
    print(event.inSeconds);
  });

  /// Countup
  var streamDurationUp = StreamDuration(Duration(seconds: 10), onDone: () {
    print('Stream Done');
  }, countUp: true, infinity: true);

  streamDurationUp.durationLeft.listen((event) {
    print(event.inSeconds);
  });
}
