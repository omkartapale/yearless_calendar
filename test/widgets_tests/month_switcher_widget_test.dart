import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:yearless_calendar/utils.dart';
import 'package:yearless_calendar/src/widgets/month_switcher_widget.dart';

void main() {
  group('Month Switcher Widget.', () {
    testWidgets('Renders correctly with default props.',
        (WidgetTester tester) async {
      debugPrint('Test: Widget should render correctly with default props.');

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MonthSwitcher(),
          ),
        ),
      );

      expect(find.byType(MonthSwitcher), findsOneWidget);
      debugPrint('\u251c Task: ✓ Find one MonthSwitcher widget.');
      expect(find.byType(Text), findsExactly(1));
      debugPrint('\u251c Task: ✓ Find one Text widget.');
      expect(find.text('January'), findsOneWidget);
      debugPrint(
          '\u2514 Task: ✓ Find one Text widget showing month name January.');

      debugPrint('✓ Test complete.');
    });

    testWidgets(
        'Renders correctly when set locale, selectedMonth and shortenedName props.',
        (WidgetTester tester) async {
      debugPrint(
          'Test: Widget should render correctly with locale, selectedMonth and shortenedName props.');

      // Init yearless calendar locale
      initializeDateFormatting();
      CalendarMonth currentMonth =
          CalendarUtils.convertDateToCalendarMonth(DateTime(2024, 4), "mr_IN");

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MonthSwitcher(
              locale: 'mr_IN',
              selectedMonth: currentMonth,
              shortenedName: true,
            ),
          ),
        ),
      );

      expect(find.byType(MonthSwitcher), findsOneWidget);
      debugPrint('\u251c Task: ✓ Find one MonthSwitcher widget.');
      expect(find.byType(Text), findsExactly(1));
      debugPrint('\u251c Task: ✓ Find one Text widget.');
      expect(find.text('एप्रि'), findsOneWidget);
      debugPrint(
          '\u2514 Task: ✓ Find one Text widget showing shortened month name with specified locale.');

      debugPrint('✓ Test complete.');
    });

    testWidgets(
        'Changes to next month and calls onMonthChange callback when next pressed.',
        (WidgetTester tester) async {
      debugPrint(
          'Test: Widget should change to next month and call onMonthChange callback.');
      CalendarMonth? callbackEmittedMonth;
      CalendarMonth expectedNextMonth =
          const CalendarMonth(name: 'February', monthNum: 2);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MonthSwitcher(
              onMonthChange: (month) => {callbackEmittedMonth = month},
            ),
          ),
        ),
      );

      final nextMonthButton = find.byKey(const Key('nextButton'));
      debugPrint('\u251c Task: ✓ Find next icon button.');
      await tester.tap(nextMonthButton);
      debugPrint('\u251c Task: ✓ Tap on next icon button.');
      expect(callbackEmittedMonth, expectedNextMonth);
      debugPrint(
          '\u2514 Task: ✓ Match next month expected and callback provided month.');

      debugPrint('✓ Test complete.');
    });

    testWidgets(
        'Changes to previous month and calls onMonthChange callback when previous pressed.',
        (WidgetTester tester) async {
      debugPrint(
          'Test: Widget should change to previous month and call onMonthChange callback.');
      CalendarMonth? callbackEmittedMonth;
      CalendarMonth currentMonth =
          const CalendarMonth(name: 'September', monthNum: 9);
      CalendarMonth expectedPreviousMonth =
          const CalendarMonth(name: 'August', monthNum: 8);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MonthSwitcher(
              selectedMonth: currentMonth,
              onMonthChange: (month) => {callbackEmittedMonth = month},
            ),
          ),
        ),
      );

      final previousMonthButton = find.byKey(const Key('prevButton'));
      debugPrint('\u251c Task: ✓ Find previous icon button.');
      await tester.tap(previousMonthButton);
      debugPrint('\u251c Task: ✓ Tap on previous icon button.');
      expect(callbackEmittedMonth, expectedPreviousMonth);
      debugPrint(
          '\u2514 Task: ✓ Match previous month expected and callback provided month.');

      debugPrint('✓ Test complete.');
    });

    testWidgets(
        'No changes in widget state and returns void callback, if widget is at January and previous button pressed.',
        (WidgetTester tester) async {
      debugPrint(
          'Test: Widget should not have any change when previous month tapped at first month of calendar.');
      CalendarMonth? callbackEmittedMonth;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MonthSwitcher(
              onMonthChange: (month) => {callbackEmittedMonth = month},
            ),
          ),
        ),
      );

      final previousMonthButton = find.byKey(const Key('prevButton'));
      debugPrint('\u251c Task: ✓ Find previous icon button.');
      // test to check disabled color of button.
      // expect(tester.widget<IconButton>(previousMonthButton).disabledColor,Theme.of(context).disabledColor);
      await tester.tap(previousMonthButton);
      debugPrint('\u251c Task: ✓ Tap on previous icon button.');
      expect(callbackEmittedMonth, null);
      debugPrint(
          '\u251c Task: ✓ Callback return void without further proccessing anything.');

      expect(find.byType(Text), findsExactly(1));
      debugPrint('\u251c Task: ✓ Find one Text widget.');
      expect(find.text('January'), findsOneWidget);
      debugPrint(
          '\u2514 Task: ✓ No update in Text widget showing month name January.');

      debugPrint('✓ Test complete.');
    });
    testWidgets(
        'No changes in widget state and returns void callback, if widget is at December and next button pressed.',
        (WidgetTester tester) async {
      debugPrint(
          'Test: Widget should not have any change when next month tapped at last month of calendar.');
      CalendarMonth currentMonth =
          const CalendarMonth(name: 'December', monthNum: 12);
      CalendarMonth? callbackEmittedMonth;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MonthSwitcher(
              selectedMonth: currentMonth,
              onMonthChange: (month) => {callbackEmittedMonth = month},
            ),
          ),
        ),
      );

      final nextMonthButton = find.byKey(const Key('nextButton'));
      debugPrint('\u251c Task: ✓ Find next icon button.');
      // test to check disabled color of button.
      // expect(tester.widget<IconButton>(nextMonthButton).disabledColor,Theme.of(context).disabledColor);
      await tester.tap(nextMonthButton);
      debugPrint('\u251c Task: ✓ Tap on next icon button.');
      expect(callbackEmittedMonth, null);
      debugPrint(
          '\u251c Task: ✓ Callback return void without further proccessing anything.');

      expect(find.byType(Text), findsExactly(1));
      debugPrint('\u251c Task: ✓ Find one Text widget.');
      expect(find.text('December'), findsOneWidget);
      debugPrint(
          '\u2514 Task: ✓ No update in Text widget showing month name December.');

      debugPrint('✓ Test complete.');
    });
  });
}
