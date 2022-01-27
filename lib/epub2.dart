import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum EKScrollDirection { vertical, horizontal }

class Epub2 {
  static const MethodChannel _channel = MethodChannel('epub2');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void setConfig({
    String identifier = 'EpubKitty',
    Color themeColor = Colors.black,
    EKScrollDirection? scrollDirection = EKScrollDirection.vertical,
    bool allowSharing = true,
    bool shouldHideNavigationOnTap = false,
  }) async {
    Map<String, dynamic> agrs = {
      "identifier": identifier,
      "themeColor": '#${themeColor.value.toRadixString(16)}',
      "scrollDirection": scrollDirection?.stringValue,
      "allowSharing": allowSharing,
      "shouldHideNavigationOnTap": shouldHideNavigationOnTap,
    };
    await _channel.invokeMethod('setConfig', agrs);
  }

  /// @param bookPath the local path in cache
  static void open(String? bookPath) async {
    if (bookPath == null || bookPath.isEmpty) throw 'bookPath cannot be empty';

    await _channel.invokeMethod('open', {
      "bookPath": bookPath,
    });
  }
}

extension ToString on EKScrollDirection {
  String get stringValue => toString().replaceAll('EKScrollDirection.', '');
}
