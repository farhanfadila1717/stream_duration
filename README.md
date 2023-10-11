## [![cover][]][cover]

A dart package for stream duration, support countdown, countup, and countup infinity.

----

### Example Countdown
```dart
import 'package:stream_duration/stream_duration.dart';


void main() {
  /// Countdown
  final streamDuration = StreamDuration(
    config: StreamDurationConfig(
      autoPlay: true,
      countDownConfig: CountDownConfig(
        duration: Duration(seconds: 10),
      ),
      onDone: () => print('Stream Done 👍'),
    ),
  );

  streamDuration.durationLeft.listen((event) {
    print(event.inSeconds);
  });
}
```

### Output Countdown

[![output][]][output]

---

### Example Count Up
```dart
import 'package:stream_duration/stream_duration.dart';


void main() {
   /// Countup
  final streamDuration = StreamDuration(
    config: StreamDurationConfig(
      autoPlay: true,
      isCountUp: true,
      countUpConfig: CountUpConfig(
        /// the duration count up will start from zero
        initialDuration: Duration.zero,
        /// max duration can count up; 
        /// onDone will called if current duration 
        /// greater than equals maxDuration
        maxDuration: Duration(seconds: 10),
      ),
      onDone: () => print('Stream Done 👍'),
    ),
  );

  streamDurationUp.durationLeft.listen((event) {
    print(event.inSeconds);
  });
}
```

### Output Count Up

[![output up][]][output up]

----

### Example Count Up Infinity
```dart
import 'package:stream_duration/stream_duration.dart';


void main() {
  final streamDuration = StreamDuration(
    config: StreamDurationConfig(
      autoPlay: true,
      isCountUp: true,
      countUpConfig: CountUpConfig(
        /// the duration count up will start from zero
        initialDuration: Duration.zero,
        /// set max duration as null
        /// for infinity count up 
        maxDuration: null,
      ),
      /// onDone never called 
      onDone: () => print('Stream Done 👍'),
    ),
  );
}
```

### Output Count Up Infinity

[![output infinity][]][output infinity]

----

### 🚧 Maintener 
[![account avatar][]][github account] <br>
**Farhan Fadila** <br>
📫 How to reach me: farhan.fadila1717@gmail.com

### ❤️ Suport Maintener
[![badge paypal][]][paypal account] [![badge linktree][]][linktree account]

[cover]: https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/stream_duration/stream_duration.png
[output]: https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/stream_duration/output.png
[output up]: https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/stream_duration/output_1.png
[output infinity]: https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/stream_duration/output_2.png
[account avatar]: https://avatars.githubusercontent.com/u/43161050?s=80
[github account]: https://github.com/farhanfadila1717
[badge linktree]: https://img.shields.io/badge/Linktree-farhanfadila-orange
[linktree account]: https://linktr.ee/farhanfadila
[badge paypal]: https://img.shields.io/badge/Donate-PayPal-00457C?logo=paypal
[paypal account]: https://www.paypal.me/farhanfadila1717

