import 'package:stream_duration/stream_duration.dart';

void main() {
  var streamDuration = StreamDuration(Duration(seconds: 10), () {
    print('Stream Done');
  });

  streamDuration.durationLeft.listen((event) {
    print(event.inSeconds);
  });
}
