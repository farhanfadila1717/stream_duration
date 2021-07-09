import 'dart:async';

class StreamDuration {
  late final StreamController<Duration> _streamController =
      StreamController<Duration>();
  Stream<Duration> get durationLeft => _streamController.stream;
  late Stream<Duration> _getDurationLeft;
  StreamSubscription<Duration>? _streamSubscription;

  StreamDuration(Duration duration, Function onDone) {
    try {
      var _durationLeft = duration;
      _getDurationLeft = Stream<Duration>.periodic(Duration(seconds: 1), (_) {
        return _durationLeft -= Duration(seconds: 1);
      });
      _streamSubscription = _getDurationLeft.listen((event) {
        if (!_streamController.isClosed) {
          _streamController.add(event);
        }

        if (event.inSeconds == 0) {
          dispose();
          Future.delayed(Duration(seconds: 1), () {
            onDone();
          });
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
