import 'dart:async';
import 'package:flutter/services.dart';

typedef ScreenshotCallback = void Function();
typedef ScreenRecordCallback = void Function(bool);

class IosInsecureScreenDetector {
  static const MethodChannel _channel =
    const MethodChannel('staking_power/ios_insecure_screen_detector');

  ScreenshotCallback? _onScreenshotCallback;
  ScreenRecordCallback? _onScreenRecordCallback;

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

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch(call.method) {
      case 'onScreenshotCallback':
        if(null != _onScreenshotCallback) {
          _onScreenshotCallback!();
        }
      break;

      case 'onScreenRecordCallback':
        bool isCaptured = call.arguments;
        if(null != _onScreenRecordCallback) {
          _onScreenRecordCallback!(isCaptured);
        }
        break;

      default:
        throw('method not defined');
    }
  }
}
