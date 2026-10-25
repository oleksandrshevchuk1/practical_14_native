import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:practical_14/native_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Справжній Kotlin-обробник повертає Hi, Mom!', (tester) async {
    expect(await NativeService().greeting(), 'Hi, Mom!');
  });
}
