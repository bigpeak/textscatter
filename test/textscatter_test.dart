// Import the necessary packages
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:textscatter/textscatter.dart'; // Replace 'your_app' with your actual app name

void main() {
  // This is a test group
  group('TextScatter Widget', () {

    testWidgets('TextScatter basic test', (WidgetTester tester) async {
      // Create the widget
      await tester.pumpWidget(MaterialApp(
        home: const  Scaffold(
          body: const TextScatter(text: 'Test'),
        ),
      ));

      // Check if the TextScatter widget is present
      expect(find.byType(TextScatter), findsOneWidget);
    });

    testWidgets('TextScatter with default text', (WidgetTester tester) async {
      // Create the widget
      await tester.pumpWidget(const  MaterialApp(
        home:    Scaffold(
          body:   TextScatter(),
        ),
      ));

      // Check if the default text 'Hello, World!' is present
      expect(find.text('Hello, World!'), findsWidgets);
    });

    // You can add more specific tests here, like checking if the animation starts,
    // if the text is scattered correctly, etc.

  });
}