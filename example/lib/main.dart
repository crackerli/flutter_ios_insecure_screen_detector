import 'package:flutter/material.dart';
import 'package:ios_insecure_screen_detector/ios_insecure_screen_detector.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  late IosInsecureScreenDetector _insecureScreenDetector;
  bool _isCaptured = false;

  @override
  void initState() {
    super.initState();
    _insecureScreenDetector = IosInsecureScreenDetector();
    _insecureScreenDetector.addListener(
      () {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return Center(
              child: Text('screenshot taken', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),)
            );
          }
        );
      },
      (isCaptured) {
        setState(() {
          _isCaptured = isCaptured;
        });
      }
    );
    isCaptured();
  }

  isCaptured() async {
    _isCaptured = await _insecureScreenDetector.isCaptured();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insecure Screen Detector'),
      ),
      body: Center(
        child: Text('Captured: ${_isCaptured ? 'YES' : 'NO'}'),
      )
    );
  }
}
