import 'package:flutter_test/flutter_test.dart';
import 'package:practical_14/main.dart' as app;

void main() {
  testWidgets('Практична 14: відкривається потрібний екран', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.text('Нативні можливості'), findsWidgets);
  });
}
