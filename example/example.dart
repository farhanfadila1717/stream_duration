import 'package:stream_duration/stream_duration.dart';

void main() {
  /// Countdown
  final streamDuration = StreamDuration(
    config: StreamDurationConfig(
      autoPlay: false,
      countDownConfig: CountDownConfig(
        duration: Duration(seconds: 10),
      ),
      onDone: () => print('Stream Done 👍'),
    ),
  );

  streamDuration.play();

  // Change duration
  // streamDuration.change(const Duration(seconds: 10));
  streamDuration.durationLeft.listen(
    (duration) {
      print('Duration $duration');
    },
  );
}
