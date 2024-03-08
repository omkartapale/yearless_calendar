// Copyright 2024 Omkar Tapale. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:yearless_calendar/src/widgets/day_widget.dart';
import 'package:yearless_calendar/src/widgets/monthly_calendar_widget.dart';

void main() {
  group('Monthly Calendar Widget.', () {
    testWidgets('Renders correctly with default props.',
        (WidgetTester tester) async {
      debugPrint('Test: Widget should render correctly with default props.');

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MonthlyCalendar(
              month: DateTime.february,
            ),
          ),
        ),
      );

      expect(find.byType(MonthlyCalendar), findsOneWidget);
      debugPrint('\u2514 Task: ✓ Find one Monthly Calendar widget.');

      debugPrint('✓ Test complete.');
    });

    testWidgets('Renders correctly when set locale property and other props.',
        (WidgetTester tester) async {
      debugPrint(
          'Test: Widget should render correctly with specified locale and other props.');

      // Init yearless calendar locale
      initializeDateFormatting();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MonthlyCalendar(
              month: DateTime.november,
              selectedDate: DateTime.now().copyWith(month: 11, day: 12),
              disabledDates: [
                DateTime.now().copyWith(month: 11, day: 13),
                DateTime(2024, 11, 11),
              ],
              isLeapyear: false,
              isLandscape: true,
              dayStructure: DayStructure.dateOnly,
              dayHeight: 40,
              dayWidth: 40,
              daySeparatorMargin: 10,
              locale: 'mr_In',
            ),
          ),
        ),
      );

      expect(find.byType(MonthlyCalendar), findsOneWidget);
      debugPrint('\u2514 Task: ✓ Find one Monthly Calendar widget.');

      debugPrint('✓ Test complete.');
    });

    // TODO: Create tests to crosscheck days for months with respect to leap year config.
    // This is working correctly and as expected in execution but if possible add tests for it.
    // Making problem in counting, returns count 12 due to LazyListWidget.

    group('Callback trigger tests for enabled or disabled day widget.', () {
      testWidgets('Triggers callback correctly when day widget tapped.',
          (WidgetTester tester) async {
        DateTime sDate = DateTime(DateTime.now().year, 2, 1);
        debugPrint(
            'Test: Widget should trigger callback when day widget tapped.');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MonthlyCalendar(
                month: DateTime.february,
                selectedDate: sDate,
                onSelectedDateChanged: (selectedDate) {
                  sDate = selectedDate;
                },
              ),
            ),
          ),
        );

        expect(find.byType(MonthlyCalendar), findsOneWidget);
        debugPrint('\u251c Task: ✓ Find one Monthly Calendar widget.');

        expect(sDate, DateTime(DateTime.now().year, 2, 1));
        debugPrint('\u251c Task: ✓ Callback is not triggered yet.');

        // final dayWidget = find.byKey(const Key('3-2'));
        final dayWidget = find.byType(Day).at(2);
        expect(dayWidget, findsOneWidget);
        debugPrint('\u251c Task: ✓ Find 3rd Feb Day widget.');
        await tester.tap(dayWidget);
        debugPrint('\u251c Task: ✓ Tap on the widget.');
        expect(sDate, DateTime(DateTime.now().year, 2, 3));
        debugPrint('\u2514 Task: ✓ Callback is triggered now.');

        debugPrint('✓ Test complete.');
      });

      testWidgets(
          'Disabled day does not trigger callback when day widget tapped.',
          (WidgetTester tester) async {
        bool callbackTriggered = false;
        debugPrint(
            'Test: Widget should not trigger callback when day widget tapped is disabled.');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MonthlyCalendar(
                month: DateTime.february,
                disabledDates: [
                  DateTime(2024, 2, 1),
                  DateTime(DateTime.now().year, 2, 3),
                ],
                onSelectedDateChanged: (selectedDate) {
                  callbackTriggered = true;
                },
              ),
            ),
          ),
        );

        expect(find.byType(MonthlyCalendar), findsOneWidget);
        debugPrint('\u251c Task: ✓ Find one Monthly Calendar widget.');

        expect(callbackTriggered, false);
        debugPrint('\u251c Task: ✓ Callback is not triggered yet.');

        final dayWidget = find.byType(Day).first;
        expect(dayWidget, findsOneWidget);
        debugPrint('\u251c Task: ✓ Find disabled 1st Feb Day widget.');
        await tester.tap(dayWidget);
        debugPrint('\u251c Task: ✓ Tap on the widget.');
        expect(callbackTriggered, false);
        debugPrint('\u2514 Task: ✓ Callback is not triggered still.');

        final dayWidget2 = find.byType(Day).at(2);
        expect(dayWidget2, findsOneWidget);
        debugPrint('\u251c Task: ✓ Find another disabled 3rd Feb Day widget.');
        await tester.tap(dayWidget2);
        debugPrint('\u251c Task: ✓ Tap on the widget.');
        expect(callbackTriggered, false);
        debugPrint('\u2514 Task: ✓ Callback is not triggered still.');

        debugPrint('✓ Test complete.');
      });
    });
  });
}
