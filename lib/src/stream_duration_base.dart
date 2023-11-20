import 'dart:async';

import 'package:stream_duration/src/config/config.dart';

const _oneSeconds = Duration(seconds: 1);

class StreamDuration {
  StreamDuration({
    required this.config,
  }) {
    _init();
  }

  final StreamController<Duration> _streamController =
      StreamController<Duration>.broadcast();

  Duration _durationLeft = Duration.zero;

  Stream<Duration> get durationLeft => _streamController.stream;

  StreamSubscription<Duration>? _streamSubscription;

  /// Duration start of count down
  /// MaxDuration when countUp is true and
  /// `infinity` and `countUpAtDuration` is false
  final StreamDurationConfig config;

  bool get isCountUp => _isCountUp;

  bool get _isCountUp => config.isCountUp;

  CountUpConfig get _countUpConfig {
    return config.countUpConfig ?? CountUpConfig.defaultConfig;
  }

  void _init() {
    if (config.isCountUp) {
      _durationLeft = _countUpConfig.initialDuration;
    } else {
      final countDownConfig = config.countDownConfig;
      if (countDownConfig == null) {
        throw Exception('CountDownConfig is required');
      }
      _durationLeft = countDownConfig.duration;
    }

    if (!_streamController.isClosed) {
      _streamController.add(_durationLeft);
    }

    if (config.autoPlay) play();
  }

  void play() {
    _streamSubscription = Stream<Duration>.periodic(
      config.periodic,
      (_) {
        if (!(_streamSubscription?.isPaused ?? true)) {
          if (_isCountUp) {
            return _durationLeft += config.periodic;
          } else {
            return _durationLeft -= config.periodic;
          }
        }
        return Duration.zero;
      },
    ).listen(
      (event) {
        if (_streamController.isClosed) return;
        _streamController.add(_durationLeft);

        if (isDone) _onDone();
      },
    );
  }

  bool get isDone {
    if (!_isCountUp && _durationLeft.inSeconds <= 0) return true;

    return _isCountUp &&
        !_countUpConfig.isInfinity &&
        _durationLeft >= _countUpConfig.maxDuration!;
  }

  void _onDone() {
    dispose();
    config.onDone?.call();
  }

  void change(Duration duration) {
    _durationLeft = duration;
    if (isDone) _onDone();
  }

  /// If you need override current duration
  /// add or subtract [_durationLeft] with other duration
  /// & countUp is true will automate add [_durationLeft]
  /// & countUp is fale will automate subtract [_durationLeft]
  void correct(Duration duration) {
    if (_isCountUp) {
      add(duration);
    } else {
      subtract(duration);
    }
  }

  void add(Duration duration) {
    _durationLeft += duration;
    if (isDone) _onDone();
  }

  void subtract(Duration duration) {
    _durationLeft -= duration;
    if (_durationLeft.isNegative) {
      throw Exception('Duration cannot be negative');
    }
    if (isDone) _onDone();
  }

  Duration get remainingDuration => _durationLeft;

  void pause() => _streamSubscription?.pause();

  void resume() => _streamSubscription?.resume();

  void dispose() {
    _streamSubscription?.cancel();
    _streamController.close();
  }
}
