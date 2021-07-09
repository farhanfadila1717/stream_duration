## Stream Duration

A dart package for stream duration.

----

### Example
```dart
import 'package:time_left/time_left.dart';

void main() {
  var streamDuration = StreamDuration(Duration(seconds: 10), () {
    print('Stream Done');
  });

  streamDuration.durationLeft.listen((event) {
    print(event.inSeconds);
  });
}
```

### Output Print Example

[![Output][]][Output]

----

### 🚧 Maintener 
<a href="https://github.com/farhanfadila1717"><img src="https://avatars.githubusercontent.com/u/43161050?s=100" width="80px;" alt="Farhan Fadila"/></a><br>
**Farhan Fadila** <br>
📫 How to reach me: farhan.fadila1717@gmail.com

### ❤️ Suport Maintener
<a href="https://flutter.dev">
    <img src="https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter"
      alt="Platform" />
  </a>
  <a href="https://www.paypal.me/farhanfadila1717">
    <img src="https://img.shields.io/badge/Donate-PayPal-00457C?logo=paypal"
      alt="Donate" />
</a>

[Output]: https://github.com/farhanfadila1717/stream_duration/blob/master/display/output.png

