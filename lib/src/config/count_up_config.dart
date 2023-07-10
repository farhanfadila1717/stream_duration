/// {@template count_up_config}
/// `CountUpConfig` class contains configuration options for
/// count up durations.
/// {@endtemplate}
class CountUpConfig {
  /// {@macro count_up_config}
  const CountUpConfig({
    required this.initialDuration,
    this.maxDuration,
  });

  /// initial duration countup start
  final Duration initialDuration;

  /// if the maxDuration is null
  /// countUp will infinity
  final Duration? maxDuration;

  static const defaultConfig = CountUpConfig(
    initialDuration: Duration.zero,
  );

  bool get isInfinity => maxDuration != null && maxDuration! >= initialDuration;

  bool isDone(Duration duration) => !isInfinity && duration >= maxDuration!;

  CountUpConfig copyWith({
    Duration? initialDuration,
    Duration? maxDuration,
  }) =>
      CountUpConfig(
        initialDuration: initialDuration ?? this.initialDuration,
        maxDuration: maxDuration ?? this.maxDuration,
      );

  @override
  bool operator ==(covariant CountUpConfig other) {
    if (identical(this, other)) return true;

    return other.initialDuration == initialDuration &&
        other.maxDuration == maxDuration;
  }

  @override
  int get hashCode => initialDuration.hashCode ^ maxDuration.hashCode;

  @override
  String toString() => '''
CountUpConfig(
  initialDuration: $initialDuration, 
  maxDuration: $maxDuration''';
}
