## [![cover][]][cover]

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

[![output][]][output]

----

### 🚧 Maintener 
[![account avatar][]][github account] <br>
**Farhan Fadila** <br>
📫 How to reach me: farhan.fadila1717@gmail.com

### ❤️ Suport Maintener
[![badge paypal][]][paypal account] [![badge linktree][]][linktree account]

[cover]: https://github.com/farhanfadila1717/flutter_package/blob/master/display/stream_duration/stream_duration.png
[output]: https://github.com/farhanfadila1717/flutter_package/blob/master/display/stream_duration/output.png
[account avatar]: https://avatars.githubusercontent.com/u/43161050?s=80
[github account]: https://github.com/farhanfadila1717
[badge linktree]: https://img.shields.io/badge/Linktree-farhanfadila-orange
[linktree account]: https://linktr.ee/farhanfadila
[badge paypal]: https://img.shields.io/badge/Donate-PayPal-00457C?logo=paypal
[paypal account]: https://www.paypal.me/farhanfadila1717

