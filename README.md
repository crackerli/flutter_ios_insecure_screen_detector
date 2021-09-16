# ios_insecure_screen_detector

A flutter plugin to detect the screenshot and screen recording on iOS.

For screenshot, events can be detected on all iOS version.
For screen recording, events can only be detected on iOS version above 11.0

Attention: this plugin work only for iOS, for androdi, please refer to [flutter_windowmanager](https://pub.dev/packages/flutter_windowmanager).

## Getting Started

## How to use

  1. In the screen, prepare two callbacks:
     <br/>typedef ScreenshotCallback = void Function();<br/>
     typedef ScreenRecordCallback = void Function(bool);
    
     ScreenshotCallback will be used to get the screenshot event.
     ScreenRecordCallback will be used to get the screen recording event, recording is on or off will be passed back.(Screen recording detector only worked above iOS 11.0)
  2. Get IosInsecureScreenDetector instance.
  3. Initialize plugin in initState()
  4. Add your callbacks to IosInsecureScreenDetector.
  5. Dispose plugin in dispose() when you exit the screen.
  6. Also you can get the current screen recording status with isCaptured()

## Apis
  /// Callbacks that contain the actions after event detected.
  <br/>ScreenshotCallback? _onScreenshotCallback;<br/>
  ScreenRecordCallback? _onScreenRecordCallback;

  /// Initialize screenshot and screen record notification observers
  <br/>Future<void> initialize()<br/>

  /// Add callback actions when screenshot or screen record events received.
  <br/>void addListener(ScreenshotCallback screenshotCallback, ScreenRecordCallback screenRecordCallback)<br/>

  /// Remove listeners
  <br/>void removeListener()<br/>

  /// Get the recording status of current screen
  <br/>Future<bool> isCaptured()<br/>

  /// Remove notification observer
  <br/>Future<void> dispose()<br/>

