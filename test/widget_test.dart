import 'package:attendease/main.dart'; // Adjust the path if necessary
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const AttendEaseApp(isDarkMode: false)); // ✅ Fixed null issue
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
