import 'package:stream_duration/stream_duration.dart';
import 'package:test/test.dart';

void main() {
  group('Test stream duration', () {
    late StreamDuration streamDuration;

    var expectOutput = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0];
    var index = 0;

    setUp(() {
      streamDuration = StreamDuration(Duration(seconds: 10), onDone: () {
        print('Stream Donde & disposed');
      });
    });
    test('Return Stream matcher dummyOutput', () {
      streamDuration.durationLeft.listen(expectAsync1((event) {
        expect(event.inSeconds, expectOutput[index]);
        index++;
      }));
    });
  });
}
