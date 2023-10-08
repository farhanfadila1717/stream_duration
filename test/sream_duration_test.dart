import 'package:stream_duration/stream_duration.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Test stream duration\n',
    () {
      late StreamDuration streamDuration;

      final expectOutput = [4, 3, 2, 1, 0];
      var index = 0;

      setUp(
        () {
          streamDuration = StreamDuration(
            config: StreamDurationConfig(
              countDownConfig: const CountDownConfig(
                duration: Duration(seconds: 5),
              ),
              onDone: () => print('Stream Done'),
            ),
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
      config: StreamDurationConfig(
        countDownConfig: const CountDownConfig(
          duration: Duration(seconds: 10),
        ),
        onDone: () => print('Stream Donde & disposed'),
      ),
    );

    // Expect initalize duration is match
    expect(streamDuration.remainingDuration.inSeconds, 10);

    // Change duration
    streamDuration.change(const Duration(seconds: 20));

    // Expect change duration match
    expect(streamDuration.remainingDuration.inSeconds, 20);
  });

  group('countUp test', () {
    late StreamDuration streamDuration;

    final expectOutput = [1, 2, 3, 4];
    var index = 0;

    setUp(
      () {
        streamDuration = StreamDuration(
          config: StreamDurationConfig(
            isCountUp: true,
            countUpConfig: const CountUpConfig(
              initialDuration: Duration.zero,
              maxDuration: const Duration(seconds: 5),
            ),
            onDone: () => print('Stream Done'),
          ),
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
  });
}
