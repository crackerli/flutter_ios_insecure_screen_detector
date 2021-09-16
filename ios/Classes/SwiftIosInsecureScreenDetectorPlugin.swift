import Flutter
import UIKit

public class SwiftIosInsecureScreenDetectorPlugin: NSObject, FlutterPlugin {

  static var channel: FlutterMethodChannel?
  static var screenshotObserver: NSObjectProtocol?
  static var screenRecordObserver: NSObjectProtocol?

  public static func register(with registrar: FlutterPluginRegistrar) {
    channel = FlutterMethodChannel(name: "staking_power/ios_insecure_screen_detector", binaryMessenger: registrar.messenger())
    screenshotObserver = nil
    screenRecordObserver = nil
    let instance = SwiftIosInsecureScreenDetectorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel!)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method == "initialize") {
      if(SwiftIosInsecureScreenDetectorPlugin.screenshotObserver != nil) {
        NotificationCenter.default.removeObserver(
          SwiftIosInsecureScreenDetectorPlugin.screenshotObserver!)
        SwiftIosInsecureScreenDetectorPlugin.screenshotObserver = nil
      }

      SwiftIosInsecureScreenDetectorPlugin.screenshotObserver = NotificationCenter.default.addObserver(
        forName: UIApplication.userDidTakeScreenshotNotification,
        object: nil,
        queue: OperationQueue.main
      ) { notification in
        if let channel = SwiftIosInsecureScreenDetectorPlugin.channel {
          channel.invokeMethod("onScreenshotCallback", arguments: nil)
        }
      }

      if #available(iOS 11.0, *) {
        if(SwiftIosInsecureScreenDetectorPlugin.screenRecordObserver != nil) {
          NotificationCenter.default.removeObserver(
            SwiftIosInsecureScreenDetectorPlugin.screenRecordObserver!)
          SwiftIosInsecureScreenDetectorPlugin.screenRecordObserver = nil
        }

        SwiftIosInsecureScreenDetectorPlugin.screenRecordObserver =
          NotificationCenter.default.addObserver(
          forName: UIScreen.capturedDidChangeNotification,
          object: nil,
          queue: OperationQueue.main) { notification in
            let isCaptured = UIScreen.main.isCaptured
            if isCaptured {
              SwiftIosInsecureScreenDetectorPlugin.channel!.invokeMethod("onScreenRecordCallback", arguments: true)
            } else {
              SwiftIosInsecureScreenDetectorPlugin.channel!.invokeMethod("onScreenRecordCallback", arguments: false)
            }
          }
      } else {
        // do nothing
      }

      result("initialize")
    } else if(call.method == "dispose") {
      if(SwiftIosInsecureScreenDetectorPlugin.screenshotObserver != nil) {
        NotificationCenter.default.removeObserver(
          SwiftIosInsecureScreenDetectorPlugin.screenshotObserver!)
        SwiftIosInsecureScreenDetectorPlugin.screenshotObserver = nil
      }

      if(SwiftIosInsecureScreenDetectorPlugin.screenRecordObserver != nil) {
        NotificationCenter.default.removeObserver(
          SwiftIosInsecureScreenDetectorPlugin.screenRecordObserver!)
        SwiftIosInsecureScreenDetectorPlugin.screenRecordObserver = nil
      }
      result("dispose")
    } else if(call.method == "isCaptured") {
      let isCaptured = UIScreen.main.isCaptured
      result(isCaptured)
    } else {
      result("")
    }
  }

  deinit {
    if(SwiftIosInsecureScreenDetectorPlugin.screenshotObserver != nil) {
      NotificationCenter.default.removeObserver(
        SwiftIosInsecureScreenDetectorPlugin.screenshotObserver!)
      SwiftIosInsecureScreenDetectorPlugin.screenshotObserver = nil
    }

    if(SwiftIosInsecureScreenDetectorPlugin.screenRecordObserver != nil) {
      NotificationCenter.default.removeObserver(SwiftIosInsecureScreenDetectorPlugin.screenRecordObserver!)
      SwiftIosInsecureScreenDetectorPlugin.screenRecordObserver = nil
    }
  }
}
