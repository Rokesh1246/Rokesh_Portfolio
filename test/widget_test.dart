import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rokesh_portfolio/theme/app_theme.dart';

void main() {
  testWidgets('Rokesh Portfolio basic smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: const Scaffold(
          body: Center(
            child: Text('ROKESH GOVINDARAJ - FLUTTER DEVELOPER'),
          ),
        ),
      ),
    );

    expect(find.text('ROKESH GOVINDARAJ - FLUTTER DEVELOPER'), findsOneWidget);
  });
}
