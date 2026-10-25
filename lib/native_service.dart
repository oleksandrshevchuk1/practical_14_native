import 'package:flutter/services.dart';

class NativeService {
  static const channel = MethodChannel('ua.edu.mobile/practical25');
  Future<String> greeting() async =>
      await channel.invokeMethod<String>('getGreeting') ??
      'Нативний код не повернув рядок';
}
