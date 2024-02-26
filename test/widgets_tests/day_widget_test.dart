// Copyright 2024 Omkar Tapale. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:yearless_calendar/src/widgets/day_widget.dart';

void main() {
  group('Day Widget.', () {
    testWidgets('Renders correctly with default props.',
        (WidgetTester tester) async {
      debugPrint('Test: Widget should render correctly with default props.');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Day(
              date: DateTime(2024),
              onDayPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(Day), findsOneWidget);
      debugPrint('\u251c Task: ✓ Find one Day widget.');
      expect(find.byType(Text), findsExactly(3));
      debugPrint('\u251c Task: ✓ Find one Text widget.');
      expect(find.text('MON'), findsOneWidget);
      debugPrint('\u251c Task: ✓ Find one Text widget showing day name MON.');
      expect(find.text('01'), findsOneWidget);
      debugPrint(
          '\u251c Task: ✓ Find one Text widget showing day of month 01.');
      expect(find.text('JAN'), findsOneWidget);
      debugPrint('\u2514 Task: ✓ Find one Text widget showing month name JAN.');

      debugPrint('✓ Test complete.');
    });
  });

  testWidgets('Renders correctly when set locale and format props.',
      (WidgetTester tester) async {
    debugPrint(
        'Test: Widget should render correctly with specified locale and format.');

    // Init yearless calendar locale
    initializeDateFormatting();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Day(
            date: DateTime(2024),
            onDayPressed: () {},
            locale: 'mr_IN',
          ),
        ),
      ),
    );

    expect(find.byType(Day), findsOneWidget);
    debugPrint('\u251c Task: ✓ Find one Day widget.');
    expect(find.byType(Text), findsExactly(3));
    debugPrint('\u251c Task: ✓ Find one Text widget.');
    expect(find.text('सोम'), findsOneWidget);
    debugPrint('\u251c Task: ✓ Find one Text widget showing day name MON.');
    expect(find.text('०१'), findsOneWidget);
    debugPrint('\u251c Task: ✓ Find one Text widget showing day of month ०१.');
    expect(find.text('जाने'), findsOneWidget);
    debugPrint('\u2514 Task: ✓ Find one Text widget showing month name जाने.');

    debugPrint('✓ Test complete.');
  });

  testWidgets('Triggers callback correctly when tapped.',
      (WidgetTester tester) async {
    bool callbackTriggered = false;
    debugPrint('Test: Widget should trigger callback when tapped.');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Day(
            date: DateTime(2024),
            onDayPressed: () {
              callbackTriggered = true;
            },
          ),
        ),
      ),
    );

    final dayWidget = find.byType(Day);
    expect(dayWidget, findsOneWidget);
    debugPrint('\u251c Task: ✓ Find one Day widget.');
    expect(callbackTriggered, false);
    debugPrint('\u251c Task: ✓ Callback is not triggered yet.');
    await tester.tap(dayWidget);
    debugPrint('\u251c Task: ✓ Tap on the widget.');
    expect(callbackTriggered, true);
    debugPrint('\u2514 Task: ✓ Callback is triggered now.');

    debugPrint('✓ Test complete.');
  });

  testWidgets('Disabled day should not trigger callback when tapped.',
      (WidgetTester tester) async {
    bool callbackTriggered = false;
    debugPrint(
        'Test: Widget should not trigger callback when tapped if disabled.');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Day(
            date: DateTime(2024),
            onDayPressed: () {
              callbackTriggered = true;
            },
            isDisabled: true,
          ),
        ),
      ),
    );

    final dayWidget = find.byType(Day);
    expect(dayWidget, findsOneWidget);
    debugPrint('\u251c Task: ✓ Find one Day widget.');
    expect(callbackTriggered, false);
    debugPrint('\u251c Task: ✓ Callback is not triggered yet.');
    await tester.tap(dayWidget);
    debugPrint('\u251c Task: ✓ Tap on the widget.');
    expect(callbackTriggered, false);
    debugPrint('\u2514 Task: ✓ Callback is not triggered still.');

    debugPrint('✓ Test complete.');
  });
}
