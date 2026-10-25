import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practical_14/native_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Dart викликає правильний канал і метод', () async {
    MethodCall? received;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(NativeService.channel, (call) async {
          received = call;
          return 'Hi, Mom!';
        });
    addTearDown(
      () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(NativeService.channel, null),
    );
    expect(await NativeService().greeting(), 'Hi, Mom!');
    expect(received!.method, 'getGreeting');
  });
}
