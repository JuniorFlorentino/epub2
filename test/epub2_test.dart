import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:epub2/epub2.dart';

void main() {
  const MethodChannel channel = MethodChannel('epub2');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Epub2.platformVersion, '42');
  });
}
