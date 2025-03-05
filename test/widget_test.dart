import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce/main.dart'; 

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

 
    expect(find.text('Please log in'), findsOneWidget);
    expect(find.text('You are logged in!'), findsNothing);
  });
}
