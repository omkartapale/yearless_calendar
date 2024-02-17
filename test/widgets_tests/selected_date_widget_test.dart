// Copyright 2024 Omkar Tapale. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:yearless_calendar/yearless_calendar.dart';

void main() {
  group('Selected Date Widget.', () {
    testWidgets('Renders correctly with default props.',
        (WidgetTester tester) async {
      debugPrint('Test: Widget should render correctly with default props.');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SelectedDate(
              date: DateTime(2024),
            ),
          ),
        ),
      );

      expect(find.byType(SelectedDate), findsOneWidget);
      debugPrint('\u251c Task: ✓ Find one SelectedDate widget.');
      expect(find.byType(Text), findsExactly(1));
      debugPrint('\u251c Task: ✓ Find one Text widget.');
      expect(find.text('Monday, 1 January'), findsOneWidget);
      debugPrint(
          '\u2514 Task: ✓ Find one Text widget showing \'Monday, 1 January\'.');

      debugPrint('✓ Test complete.');
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
            body: SelectedDate(
              date: DateTime(2024),
              locale: 'mr_IN',
              format: SelectedDateFormat.date,
            ),
          ),
        ),
      );

      expect(find.byType(SelectedDate), findsOneWidget);
      debugPrint('\u251c Task: ✓ Find one SelectedDate widget.');
      expect(find.byType(Text), findsExactly(1));
      debugPrint('\u251c Task: ✓ Find one Text widget.');
      expect(find.text('१ जानेवारी'), findsOneWidget);
      debugPrint(
          '\u2514 Task: ✓ Find one Text widget showing in \'date month\' format with specified locale.');

      debugPrint('✓ Test complete.');
    });
  });
}
