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
  final bool countUpAtDuration;
  final bool infinity;
  final bool autoPlay;

  StreamDuration(
    this.duration, {
    this.countUp = false,
    this.countUpAtDuration = false,
    this.infinity = false,
    this.onDone,
    this.autoPlay = true,
  }) {
    _durationLeft = countUp ? Duration.zero : duration;
    if(countUp&&countUpAtDuration){
      _durationLeft = duration;
    }
    if (duration.inSeconds <= 0 && !countUp) return;
    if (autoPlay) {
      play();
      isPlaying = true;
    }
  }

  void play() {
    if (_streamController.hasListener) return;
    if (countUp) {
      _durationLeft += const Duration(seconds: 1);
    } else {
      _durationLeft -= const Duration(seconds: 1);
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

  void change(Duration duration) {
    if (countUp) {
      if (_durationLeft > duration) {
        dispose();
        Future.delayed(Duration(seconds: 1), () {
          if (onDone != null) {
            onDone!();
          }
        });
      } else {
        _durationLeft = duration;
      }
    } else {
      _durationLeft = duration;
    }
  }

  /// If you need override current duration
  /// add or subtract [_durationLeft] with other duration
  /// & [countUp] is true will automate add [_durationLeft]
  /// & [countUp] is fale will automate subtract [_durationLeft]
  void correct(Duration duration) {
    if (countUp) {
      add(duration);
    } else {
      subtract(duration);
    }
  }

  void add(Duration duration) {
    if (countUp && !infinity && duration >= _durationLeft) {
      _durationLeft += duration;
      dispose();
      Future.delayed(Duration(seconds: 1), () {
        if (onDone != null) {
          onDone!();
        }
      });
    } else {
      _durationLeft += duration;
    }
  }

  void subtract(Duration duration) {
    if (!countUp && _durationLeft <= duration) {
      _durationLeft = Duration.zero;
      dispose();
      Future.delayed(Duration(seconds: 1), () {
        if (onDone != null) {
          onDone!();
        }
      });
    } else {
      if (_durationLeft <= duration) {
        _durationLeft = Duration.zero;
        dispose();
        Future.delayed(Duration(seconds: 1), () {
          if (onDone != null) {
            onDone!();
          }
        });
      } else {
        _durationLeft -= duration;
      }
    }
  }

  Duration get remainingDuration => _durationLeft;

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
