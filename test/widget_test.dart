// Basic Flutter widget test for IUB Social app.

import 'package:flutter_test/flutter_test.dart';

import 'package:iub_social/main.dart';

void main() {
  testWidgets('IUB Social app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const IUBSocialApp());

    // Verify that IUB Social title exists
    expect(find.text('IUB Social'), findsOneWidget);
    
    // Verify that navigation items exist
    expect(find.text('Feed'), findsOneWidget);
    expect(find.text('Browse'), findsOneWidget);
    expect(find.text('Chats'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}
