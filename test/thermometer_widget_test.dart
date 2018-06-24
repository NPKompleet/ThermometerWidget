import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thermometer/main.dart';
import 'package:thermometer/thermometer_widget.dart';

void main() {
  Widget createDefaultThermometerWidget() {
    return Center(
      child: RepaintBoundary(child: ThermometerWidget()),
    );
  }

  Widget createThermometerWidgetWithColors() {
    return Center(
      child: RepaintBoundary(
          child: ThermometerWidget(
        borderColor: Colors.red,
        innerColor: Colors.green,
        indicatorColor: Colors.red,
      )),
    );
  }

  Widget createThermometerWidgetWithColorsAnd100Degrees() {
    return Center(
      child: RepaintBoundary(
          child: ThermometerWidget(
        borderColor: Colors.red,
        innerColor: Colors.green,
        indicatorColor: Colors.red,
        temperature: 100.0,
      )),
    );
  }

  Widget createThermometerWidgetWithColorsAndZeroDegrees() {
    return Center(
      child: RepaintBoundary(
          child: ThermometerWidget(
        borderColor: Colors.red,
        innerColor: Colors.green,
        indicatorColor: Colors.red,
        temperature: 0.0,
      )),
    );
  }

  testWidgets('Widget test', (WidgetTester tester) async {
    await tester.pumpWidget(new MyApp());

    // Check if the thermometer widget is present in the app.
    expect(find.byType(ThermometerWidget), findsOneWidget);

    // Check that the ThermometerWidget has a CustomPaint child
    expect(
        find.descendant(
            of: find.byType(ThermometerWidget),
            matching: find.byType(CustomPaint)),
        findsOneWidget);
  });

  testWidgets('Default ThermometerWidget matches goldenfile test',
      (WidgetTester tester) async {
    Widget widget = createDefaultThermometerWidget();
    await tester.pumpWidget(widget);
    await expectLater(
      find.byType(ThermometerWidget),
      matchesGoldenFile('golden/defaultThermometerGoldenImage.png'),
      skip: !Platform.isWindows,
    );
  });

  testWidgets('ThermometerWidget with color matches goldenfile test',
      (WidgetTester tester) async {
    Widget widget = createThermometerWidgetWithColors();
    await tester.pumpWidget(widget);
    await expectLater(
      find.byType(ThermometerWidget),
      matchesGoldenFile('golden/thermometerWithColorsGoldenImage.png'),
      skip: !Platform.isWindows,
    );
  });

  testWidgets(
      'ThermometerWidget with color and 100 degrees Celsius matches golden file',
      (WidgetTester tester) async {
    Widget widget = createThermometerWidgetWithColorsAnd100Degrees();
    await tester.pumpWidget(widget);
    await expectLater(
      find.byType(ThermometerWidget),
      matchesGoldenFile('golden/thermometerWithColorsAnd100DegGoldenImage.png'),
      skip: !Platform.isWindows,
    );
  });

  testWidgets(
      'ThermometerWidget with color and 0 degrees Celsius matches golden file',
      (WidgetTester tester) async {
    Widget widget = createThermometerWidgetWithColorsAndZeroDegrees();
    await tester.pumpWidget(widget);
    await expectLater(
      find.byType(ThermometerWidget),
      matchesGoldenFile(
          'golden/thermometerWithColorsAndZeroDegGoldenImage.png'),
      skip: !Platform.isWindows,
    );
  });
}
