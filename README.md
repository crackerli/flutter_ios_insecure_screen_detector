# ios_insecure_screen_detector

A flutter plugin to detect the screenshot and screen recording on iOS.

For screenshot, events can be detected on all iOS version.
For screen recording, events can only be detected on iOS version above 11.0

Attention: this plugin work only for iOS, for androdi, please refer to [flutter_windowmanager](https://pub.dev/packages/flutter_windowmanager).

## Getting Started

  /// Callbacks that contain the actions after event detected.
  ScreenshotCallback? _onScreenshotCallback;
  ScreenRecordCallback? _onScreenRecordCallback;

  /// Create detector and initialize the observers on iOS system.
  IosInsecureScreenDetector() {
    initialize();
  }

  /// Initialize screenshot and screen record observers
  Future<void> initialize() async {
    _channel.setMethodCallHandler(_handleMethod);
    await _channel.invokeMethod('initialize');
  }

  /// Add callback actions when screenshot or screen record events received.
  void addListener(ScreenshotCallback screenshotCallback, ScreenRecordCallback screenRecordCallback) {
    _onScreenshotCallback = screenshotCallback;
    _onScreenRecordCallback = screenRecordCallback;
  }

  /// Remove listeners
  void removeListener() {
    _onScreenshotCallback = null;
    _onScreenRecordCallback = null;
  }

  /// Get the recording status of current screen
  Future<bool> isCaptured() async => await _channel.invokeMethod('isCaptured');

  /// Remove notification observer
  Future<void> dispose() async {
    removeListener();
    await _channel.invokeMethod('dispose');
  }

