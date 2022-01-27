import 'dart:async';

import 'package:flutter/services.dart';

class Epub2 {
  static const MethodChannel _channel = MethodChannel('epub2');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// @param identifier unique key for epub
  /// @param themeColor
  /// @param scrollDirection
  /// @param allowSharing
  static void setConfig(String identifier, String themeColor,
      String scrollDirection, bool allowSharing,
      {bool shouldHideNavigationOnTap = false}) async {
    Map<String, dynamic> agrs = {
      "identifier": identifier,
      "themeColor": themeColor,
      "scrollDirection": scrollDirection,
      "allowSharing": allowSharing,
      "shouldHideNavigationOnTap": shouldHideNavigationOnTap,
    };
    await _channel.invokeMethod('setConfig', agrs);
  }

  /// @param bookPath the local path in cache
  static void open(String bookPath) async {
    Map<String, dynamic> agrs = {
      "bookPath": bookPath,
    };
    await _channel.invokeMethod('open', agrs);
  }
}