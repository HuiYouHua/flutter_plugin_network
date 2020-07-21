import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPluginNetwork {
  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin_network');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> doRequest(url, params) async {
    final String result = await _channel.invokeMethod('doRequest', {
      "url": url,
      "param": params,
    });
    return result;
  }
}
