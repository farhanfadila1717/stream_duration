import 'package:stream_duration/stream_duration.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Test stream duration\n',
    () {
      late StreamDuration streamDuration;

      var expectOutput = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0];
      var index = 0;

      setUp(
        () {
          streamDuration = StreamDuration(
            Duration(seconds: 10),
            onDone: () {
              print('Stream Donde & disposed');
            },
          );
        },
      );
      test(
        'Return Stream match',
        () {
          streamDuration.durationLeft.listen(
            expectAsync1(
              (event) {
                expect(event.inSeconds, expectOutput[index]);
                index++;
              },
            ),
          );
        },
      );
    },
  );

  test('Change duration test', () {
    final streamDuration = StreamDuration(
      Duration(seconds: 10),
      onDone: () {
        print('Stream Donde & disposed');
      },
    );

    // Expect initalize duration is match
    expect(streamDuration.remainingDuration.inSeconds, 10);

    // Change duration
    streamDuration.changeDuration(Duration(seconds: 20));

    // Expect change duration match
    expect(streamDuration.remainingDuration.inSeconds, 20);
  });
}
