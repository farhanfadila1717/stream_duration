import 'dart:async';

import 'package:stream_duration/src/utils.dart';

const _oneSeconds = Duration(seconds: 1);

class StreamDuration {
  final StreamController<Duration> _streamController =
      StreamController<Duration>();

  Duration _durationLeft = Duration.zero;

  Stream<Duration> get durationLeft => _streamController.stream;

  StreamSubscription<Duration>? _streamSubscription;

  /// Duration start of count down
  /// MaxDuration when countUp is true and
  /// `infinity` and `countUpAtDuration` is false
  final Duration duration;

  /// if true Duration will increment
  /// if false Duration will decrement
  final bool countUp;

  /// count up start at `duration`
  /// if this true count up is `infinity`
  final bool countUpAtDuration;

  /// only effect when `countUp`
  final bool infinity;

  /// Auto play when `StreamDuration` initialized
  final bool autoPlay;

  /// When duration is count down duration is equal remainingDuration
  /// onDone will called
  ///
  /// Never called when `countUp` is `infinity` or `countUpAtDuration`
  final Function? onDone;

  StreamDuration(
    this.duration, {
    this.countUp = false,
    this.autoPlay = true,
    this.countUpAtDuration = false,
    this.infinity = false,
    this.onDone,
  }) {
    if (duration.inSeconds <= 0 && !countUp) return;

    if (autoPlay) play();
  }

  void play() {
    if (countUp) {
      if (countUpAtDuration) {
        _durationLeft = duration;
      } else {
        _durationLeft = Duration.zero;
      }
      _durationLeft += _oneSeconds;
    } else {
      _durationLeft = duration;
      _durationLeft -= _oneSeconds;
    }

    if (!_streamController.isClosed) {
      _streamController.add(_durationLeft);
    }

    _streamSubscription = Stream<Duration>.periodic(
      _oneSeconds,
      (_) {
        if (!(_streamSubscription?.isPaused ?? true)) {
          if (countUp) {
            return _durationLeft += _oneSeconds;
          } else {
            return _durationLeft -= _oneSeconds;
          }
        }
        return Duration.zero;
      },
    ).listen(
      (event) {
        if (_streamController.isClosed) return;
        _streamController.add(_durationLeft);

        if (countUp) {
          if (!infinity) {
            if (_durationLeft.isSameDuration(duration)) {
              _onDone();
            }
          }
        } else {
          if (_durationLeft.inSeconds == 0) {
            _onDone();
          }
        }
      },
    );
  }

  void _onDone() {
    _dispose();
    Future.delayed(_oneSeconds, () {
      onDone?.call();
    });
  }

  void change(Duration duration) {
    if (countUp) {
      if (_durationLeft > duration && !infinity) {
        _onDone();
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
    _durationLeft += duration;
    if (countUp && !infinity && duration >= _durationLeft) {
      _onDone();
    }
  }

  void subtract(Duration duration) {
    if (!countUp && _durationLeft <= duration) {
      _durationLeft = Duration.zero;
      _onDone();
    } else {
      if (_durationLeft <= duration) {
        _durationLeft = Duration.zero;
        _onDone();
      } else {
        _durationLeft -= duration;
      }
    }
  }

  Duration get remainingDuration => _durationLeft;

  void pause() => _streamSubscription?.pause();

  void resume() => _streamSubscription?.resume();

  void _dispose() {
    _streamSubscription?.pause();
  }

  void disponse() {
    _streamSubscription?.cancel();
    _streamController.close();
  }
}
