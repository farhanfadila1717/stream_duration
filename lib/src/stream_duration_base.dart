import 'dart:async';

class StreamDuration {
  late final StreamController<Duration> _streamController =
      StreamController<Duration>();
  Stream<Duration> get durationLeft => _streamController.stream;
  StreamSubscription<Duration>? _streamSubscription;

  StreamDuration(Duration duration, Function onDone) {
    try {
      var _durationLeft = duration;

      _streamSubscription =
          Stream<Duration>.periodic(Duration(seconds: 1), (_) {
        return _durationLeft -= Duration(seconds: 1);
      }).listen((event) {
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
