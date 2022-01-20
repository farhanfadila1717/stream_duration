import 'dart:async';

extension DurationExtension on Duration {
  bool isSameDuration(Duration b) {
    return inSeconds == b.inSeconds;
  }
}

class StreamDuration {
  final StreamController<Duration> _streamController =
      StreamController<Duration>();
  late Duration _durationLeft;
  bool isPlaying = false;
  Stream<Duration> get durationLeft => _streamController.stream;
  StreamSubscription<Duration>? _streamSubscription;

  final Duration duration;
  final Function? onDone;
  final bool countUp;
  final bool infinity;
  final bool autoPlay;

  StreamDuration(
    this.duration, {
    this.countUp = false,
    this.infinity = false,
    this.onDone,
    this.autoPlay = true,
  }) {
    _durationLeft = duration;
    if (autoPlay) {
      play();
      isPlaying = true;
    }
  }

  void play() {
    if (_streamController.hasListener) return;
    print('Play');
    if (countUp) {
      _durationLeft += Duration(seconds: 1);
    } else {
      _durationLeft -= Duration(seconds: 1);
    }
    if (!_streamController.isClosed) {
      _streamController.add(_durationLeft);
    }

    _streamSubscription = Stream<Duration>.periodic(Duration(seconds: 1), (_) {
      if (!(_streamSubscription?.isPaused ?? true)) {
        if (countUp) {
          return _durationLeft += Duration(seconds: 1);
        } else {
          return _durationLeft -= Duration(seconds: 1);
        }
      }
      return Duration.zero;
    }).listen(
      (event) {
        if (_streamController.isClosed) return;
        _streamController.add(_durationLeft);

        if (countUp) {
          if (!infinity) {
            if (_durationLeft.isSameDuration(duration)) {
              dispose();
              Future.delayed(Duration(seconds: 1), () {
                if (onDone != null) {
                  onDone!();
                }
              });
            }
          }
        } else {
          if (_durationLeft.inSeconds == 0) {
            dispose();
            Future.delayed(Duration(seconds: 1), () {
              if (onDone != null) {
                onDone!();
              }
            });
          }
        }
      },
    );
  }

  void pause() {
    _streamSubscription?.pause();
  }

  void resume() {
    _streamSubscription?.resume();
  }

  void dispose() {
    _streamSubscription?.cancel();
    _streamController.close();
  }
}
