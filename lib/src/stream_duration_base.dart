import 'dart:async';

class StreamDuration {
  late final StreamController<Duration> _streamController =
      StreamController<Duration>();
  Stream<Duration> get durationLeft => _streamController.stream;
  StreamSubscription<Duration>? _streamSubscription;

  StreamDuration(
    Duration duration, {
    Function? onDone,
    bool countUp = false,
    bool infinity = false,
  }) {
    try {
      var _durationLeft = countUp ? Duration.zero : duration;
      if (countUp) {
        _durationLeft += Duration(seconds: 1);
      } else {
        _durationLeft -= Duration(seconds: 1);
      }
      if (!_streamController.isClosed) {
        _streamController.add(_durationLeft);
      }
      _streamSubscription =
          Stream<Duration>.periodic(Duration(seconds: 1), (_) {
        if (countUp) {
          return _durationLeft += Duration(seconds: 1);
        } else {
          return _durationLeft -= Duration(seconds: 1);
        }
      }).listen((event) {
        if (!_streamController.isClosed) {
          _streamController.add(event);
        }

        if (countUp) {
          if (!infinity) {
            if (event.isSameDuration(duration)) {
              dispose();
              Future.delayed(Duration(seconds: 1), () {
                if (onDone != null) {
                  onDone();
                }
              });
            }
          }
        } else {
          if (event.inSeconds == 0) {
            dispose();
            Future.delayed(Duration(seconds: 1), () {
              if (onDone != null) {
                onDone();
              }
            });
          }
        }
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  void dispose() {
    _streamSubscription?.cancel();
    _streamController.close();
  }
}

extension DurationExtension on Duration {
  bool isSameDuration(Duration b) {
    return inSeconds == b.inSeconds;
  }
}
