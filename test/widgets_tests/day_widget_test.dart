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
      debugPrint('\u251c Task: ✓ Find three Text widgets.');

      expect(find.text('MON'), findsOneWidget);
      debugPrint('\u251c Task: ✓ Find one Text widget showing day name MON.');
      expect(find.text('01'), findsOneWidget);
      debugPrint(
          '\u251c Task: ✓ Find one Text widget showing day of month 01.');
      expect(find.text('JAN'), findsOneWidget);
      debugPrint('\u2514 Task: ✓ Find one Text widget showing month name JAN.');

      debugPrint('✓ Test complete.');
    });

    testWidgets('Renders correctly when set locale property.',
        (WidgetTester tester) async {
      debugPrint('Test: Widget should render correctly with specified locale.');

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
      debugPrint('\u251c Task: ✓ Find three Text widgets.');

      expect(find.text('सोम'), findsOneWidget);
      debugPrint('\u251c Task: ✓ Find one Text widget showing day name सोम.');
      expect(find.text('०१'), findsOneWidget);
      debugPrint(
          '\u251c Task: ✓ Find one Text widget showing day of month ०१.');
      expect(find.text('जाने'), findsOneWidget);
      debugPrint(
          '\u2514 Task: ✓ Find one Text widget showing month name जाने.');

      debugPrint('✓ Test complete.');
    });

    group('Callback trigger tests for enabled or disabled widget.', () {
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

      testWidgets('Disabled day does not trigger callback when tapped.',
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
    });

    group('Rendering day widget tests with specified dayStructure.', () {
      testWidgets(
          'Renders correctly when dayStructure property is set to dateDay.',
          (WidgetTester tester) async {
        debugPrint(
            'Test: Widget should render with only date and day elements in respective order.');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Day(
                date: DateTime(2024),
                onDayPressed: () {},
                dayStructure: DayStructure.dateDay,
              ),
            ),
          ),
        );

        expect(find.byType(Day), findsOneWidget);
        debugPrint('\u251c Task: ✓ Find one Day widget.');
        expect(find.byType(Text), findsExactly(2));
        debugPrint('\u251c Task: ✓ Find two Text widgets.');

        final dateElementText = find.byKey(const Key('dateElementText'));
        expect(dateElementText, findsOneWidget);
        debugPrint('\u251c Task: ✓ Find dateElementText widget.');
        expect(tester.widget<Text>(dateElementText).data, '01');
        debugPrint('\u251c Task: ✓ dateElementText widget showing date 01.');

        final dayElementText = find.byKey(const Key('dayElementText'));
        expect(dayElementText, findsOneWidget);
        debugPrint('\u251c Task: ✓ Find dayElementText widget.');
        expect(tester.widget<Text>(dayElementText).data, 'MON');
        debugPrint(
            '\u251c Task: ✓ dayElementText widget showing day name MON.');

        final monthElementText = find.byKey(const Key('monthElementText'));
        expect(monthElementText, findsNothing);
        debugPrint(
            '\u2514 Task: ✓ Find nothing when search for monthElementText widget.');

        debugPrint('✓ Test complete.');
      });

      testWidgets(
          'Renders correctly when dayStructure property is set to dateOnly.',
          (WidgetTester tester) async {
        debugPrint('Test: Widget should render with only date element.');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Day(
                date: DateTime(2024),
                onDayPressed: () {},
                dayStructure: DayStructure.dateOnly,
              ),
            ),
          ),
        );

        expect(find.byType(Day), findsOneWidget);
        debugPrint('\u251c Task: ✓ Find one Day widget.');
        expect(find.byType(Text), findsOne);
        debugPrint('\u251c Task: ✓ Find one Text widget.');

        final dateElementText = find.byKey(const Key('dateElementText'));
        expect(dateElementText, findsOneWidget);
        debugPrint('\u251c Task: ✓ Find dateElementText widget.');
        expect(tester.widget<Text>(dateElementText).data, '01');
        debugPrint('\u251c Task: ✓ dateElementText widget showing date 01.');

        final dayElementText = find.byKey(const Key('dayElementText'));
        expect(dayElementText, findsNothing);
        debugPrint(
            '\u251c Task: ✓ Find nothing when search for dayElementText widget.');

        final monthElementText = find.byKey(const Key('monthElementText'));
        expect(monthElementText, findsNothing);
        debugPrint(
            '\u2514 Task: ✓ Find nothing when search for monthElementText widget.');

        debugPrint('✓ Test complete.');
      });
      testWidgets(
          'Renders correctly when dayStructure property is set to dayDate.',
          (WidgetTester tester) async {
        debugPrint(
            'Test: Widget should render with only day and date elements in respective order.');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Day(
                date: DateTime(2024),
                onDayPressed: () {},
                dayStructure: DayStructure.dayDate,
              ),
            ),
          ),
        );

        expect(find.byType(Day), findsOneWidget);
        debugPrint('\u251c Task: ✓ Find one Day widget.');
        expect(find.byType(Text), findsExactly(2));
        debugPrint('\u251c Task: ✓ Find two Text widgets.');

        final dayElementText = find.byKey(const Key('dayElementText'));
        expect(dayElementText, findsOneWidget);
        debugPrint('\u251c Task: ✓ Find dayElementText widget.');
        expect(tester.widget<Text>(dayElementText).data, 'MON');
        debugPrint(
            '\u251c Task: ✓ dayElementText widget showing day name MON.');

        final dateElementText = find.byKey(const Key('dateElementText'));
        expect(dateElementText, findsOneWidget);
        debugPrint('\u251c Task: ✓ Find dateElementText widget.');
        expect(tester.widget<Text>(dateElementText).data, '01');
        debugPrint('\u251c Task: ✓ dateElementText widget showing date 01.');

        final monthElementText = find.byKey(const Key('monthElementText'));
        expect(monthElementText, findsNothing);
        debugPrint(
            '\u2514 Task: ✓ Find nothing when search for monthElementText widget.');

        debugPrint('✓ Test complete.');
      });

      testWidgets(
          'Renders correctly when dayStructure property is set to monthDateDay.',
          (WidgetTester tester) async {
        debugPrint(
            'Test: Widget should render with month, date and day elements in respective order.');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Day(
                date: DateTime(2024),
                onDayPressed: () {},
                dayStructure: DayStructure.monthDateDay,
              ),
            ),
          ),
        );

        expect(find.byType(Day), findsOneWidget);
        debugPrint('\u251c Task: ✓ Find one Day widget.');
        expect(find.byType(Text), findsExactly(3));
        debugPrint('\u251c Task: ✓ Find three Text widgets.');

        final monthElementText = find.byKey(const Key('monthElementText'));
        expect(monthElementText, findsOneWidget);
        debugPrint('\u251c Task: ✓ Find monthElementText widget.');
        expect(tester.widget<Text>(monthElementText).data, 'JAN');
        debugPrint(
            '\u251c Task: ✓ monthElementText widget showing month name JAN.');

        final dateElementText = find.byKey(const Key('dateElementText'));
        expect(dateElementText, findsOneWidget);
        debugPrint('\u251c Task: ✓ Find dateElementText widget.');
        expect(tester.widget<Text>(dateElementText).data, '01');
        debugPrint('\u251c Task: ✓ dateElementText widget showing date 01.');

        final dayElementText = find.byKey(const Key('dayElementText'));
        expect(dayElementText, findsOneWidget);
        debugPrint('\u251c Task: ✓ Find dayElementText widget.');
        expect(tester.widget<Text>(dayElementText).data, 'MON');
        debugPrint(
            '\u2514 Task: ✓ dayElementText widget showing day name MON.');

        debugPrint('✓ Test complete.');
      });
    });
  });
}
