import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp_control/otp_control.dart';

void main() {
  testWidgets('OtpField renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: OtpField(),
        ),
      ),
    );

    // Check that 6 input fields are rendered (default length)
    expect(find.byType(TextField), findsNWidgets(6));
  });

  testWidgets('OtpField custom length works', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: OtpField(length: 4),
        ),
      ),
    );

    expect(find.byType(TextField), findsNWidgets(4));
  });
}